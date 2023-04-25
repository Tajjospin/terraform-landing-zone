##### create the hosted private zone
resource "aws_route53_zone" "private-1" {
  name = var.PRIV_DOMAIN_NAME_1

  vpc {
    vpc_id = var.SHARED_VPC_ID
  }
  lifecycle {
    ignore_changes = [vpc]
  }
}

resource "aws_route53_record" "record-1" {
  for_each = { for record in var.LIST_RECORD : record.name => record }
  zone_id  = aws_route53_zone.private-1.zone_id
  name     = each.value.name
  type     = each.value.type
  ttl      = each.value.ttl
  records  = each.value.records
}

#### create DNS - VPC association demand

resource "aws_route53_vpc_association_authorization" "main" {
  for_each = { for vpc in var.LIST_VPC_ID : vpc.name => vpc }
  vpc_id   = each.value.ID
  zone_id  = aws_route53_zone.private-1.id
}

#### accept DNS-VPC association in each AWS account

resource "aws_route53_zone_association" "link" {
  for_each = { for vpc in var.LIST_VPC_ID : vpc.name => vpc }
  provider = each.value.provider

  vpc_id  = each.value.ID
  zone_id = aws_route53_zone.private-1.id
}