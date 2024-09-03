locals {
  ami_filter = "Windows_Server-2022-English-Full-Base-*"
}

data "aws_ami" "windows" {
  most_recent = true
  filter {
    name   = "name"
    values = [local.ami_filter]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

data "aws_subnet" "this" {
  id = var.subnet_id
}

locals {
  ami_id           = var.ami_id != null ? var.ami_id : data.aws_ami.windows.id
  root_volume_size = var.root_volume_size == 0 ? null : var.root_volume_size
  extra_volumes    = { for volume in var.extra_volumes : volume.device_name => volume }
}

resource "aws_instance" "this" {
  ami                     = local.ami_id
  disable_api_termination = var.instance_termination_disable
  key_name                = var.ssh_key_name
  vpc_security_group_ids  = var.vpc_security_group_ids
  subnet_id               = data.aws_subnet.this.id
  iam_instance_profile    = var.iam_profile_name
  instance_type           = var.instance_type

  root_block_device {
    delete_on_termination = var.root_volume_delete
    encrypted             = var.root_volume_encrypted
    volume_type           = var.root_volume_type
    volume_size           = local.root_volume_size
    kms_key_id            = var.kms_key_id
  }

  enclave_options {
    enabled = var.enclave_enabled
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = merge(var.tags, {
    Name = var.name
  })

  lifecycle {
    ignore_changes = [ami, tags]
  }

}

resource "aws_eip" "this" {
  count    = var.associate_public_ip_address ? 1 : 0
  instance = aws_instance.this.id
  domain   = "vpc"
}

resource "aws_ebs_volume" "this" {
  for_each = local.extra_volumes

  availability_zone = data.aws_subnet.this.availability_zone
  size              = each.value.size
  encrypted         = each.value.encrypted
  kms_key_id        = var.kms_key_id
  snapshot_id       = each.value.snapshot_id
  type              = each.value.type
  final_snapshot    = each.value.final_snapshot

  tags = merge(each.value.tags, {
    Name = each.value.name
  })
}

resource "aws_volume_attachment" "this" {
  depends_on = [aws_ebs_volume.this]
  for_each   = local.extra_volumes

  device_name = each.value.device_name
  instance_id = aws_instance.this.id
  volume_id   = aws_ebs_volume.this[each.key].id
}
