locals {
  has_ad_domain_id = var.ad_domain_id != null && var.ad_domain_id != ""
}

data "aws_directory_service_directory" "this" {
  count        = local.has_ad_domain_id ? 1 : 0
  directory_id = var.ad_domain_id
}

resource "aws_ssm_document" "ad_join_domain" {
  count         = local.has_ad_domain_id ? 1 : 0
  name          = "${var.name}-ad-join-domain"
  document_type = "Command"
  content = jsonencode(
    {
      "schemaVersion" = "2.2"
      "description"   = "aws:domainJoin"
      "mainSteps" = [
        {
          "action" = "aws:domainJoin",
          "name"   = "domainJoin",
          "inputs" = {
            "directoryId" : data.aws_directory_service_directory.this[0].id,
            "directoryName" : data.aws_directory_service_directory.this[0].name
            "dnsIpAddresses" : sort(data.aws_directory_service_directory.this[0].dns_ip_addresses)
          }
        }
      ]
    }
  )
}

resource "aws_ssm_association" "this" {
  count = local.has_ad_domain_id ? 1 : 0
  name  = aws_ssm_document.ad_join_domain.name
  targets {
    key    = "InstanceIds"
    values = [aws_instance.this.id]
  }
}
