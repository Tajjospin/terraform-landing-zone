
#### accept DNS-VPC association in each AWS account

resource "aws_route53_zone_association" "link" {
  for_each = { for vpc in var.LIST_VPC_ID : vpc.name => vpc }

  vpc_id  = each.value.ID
  zone_id = var.DNS_ZONE_ID
}