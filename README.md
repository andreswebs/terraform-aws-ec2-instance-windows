# terraform-aws-ec2-instance-windows



## Authors

**Andre Silva** - [@andreswebs](https://github.com/andreswebs)

## License

This project is licensed under the [Unlicense](UNLICENSE.md).

[//]: # (BEGIN_TF_DOCS)


## Usage

Example:

```hcl

```



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | n/a | `string` | `null` | no |
| <a name="input_app_gid"></a> [app\_gid](#input\_app\_gid) | n/a | `number` | `2000` | no |
| <a name="input_app_is_sudoer"></a> [app\_is\_sudoer](#input\_app\_is\_sudoer) | n/a | `bool` | `false` | no |
| <a name="input_app_uid"></a> [app\_uid](#input\_app\_uid) | n/a | `number` | `2000` | no |
| <a name="input_app_username"></a> [app\_username](#input\_app\_username) | n/a | `string` | `null` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | n/a | `bool` | `false` | no |
| <a name="input_enclave_enabled"></a> [enclave\_enabled](#input\_enclave\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_extra_volumes"></a> [extra\_volumes](#input\_extra\_volumes) | n/a | <pre>list(object({<br>    device_name    = string<br>    name           = optional(string, null)<br>    encrypted      = optional(bool, true)<br>    snapshot_id    = optional(string, null)<br>    final_snapshot = optional(bool, false)<br>    type           = optional(string, "gp3")<br>    size           = optional(number, 50)<br>    tags           = optional(map(string), {})<br>    uid            = optional(number, null)<br>    gid            = optional(number, null)<br>    mount_path     = optional(string, null)<br>  }))</pre> | `[]` | no |
| <a name="input_iam_profile_name"></a> [iam\_profile\_name](#input\_iam\_profile\_name) | n/a | `string` | n/a | yes |
| <a name="input_instance_termination_disable"></a> [instance\_termination\_disable](#input\_instance\_termination\_disable) | n/a | `bool` | `false` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"m7a.xlarge"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | n/a | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_root_volume_delete"></a> [root\_volume\_delete](#input\_root\_volume\_delete) | n/a | `bool` | `true` | no |
| <a name="input_root_volume_encrypted"></a> [root\_volume\_encrypted](#input\_root\_volume\_encrypted) | n/a | `bool` | `true` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | n/a | `number` | `0` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | n/a | `string` | `"gp3"` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | n/a | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_user_data_replace_on_change"></a> [user\_data\_replace\_on\_change](#input\_user\_data\_replace\_on\_change) | n/a | `bool` | `false` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |

## Modules

No modules.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | n/a |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_volume_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_ami.windows](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

[//]: # (END_TF_DOCS)