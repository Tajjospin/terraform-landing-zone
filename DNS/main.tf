
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
  for_each = {for record in var.LIST_RECORD : record.name => record}
  zone_id = aws_route53_zone.private-1.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}

#### create DNS - VPC association demand

resource "aws_route53_vpc_association_authorization" "main" {
    for_each = {for vpc in var.LIST_VPC_ID : vpc.name => vpc}
  vpc_id  = each.value.ID
  zone_id = aws_route53_zone.private-1.id
}

#### accept DNS-VPC association in each AWS account

resource "aws_route53_zone_association" "link-2" {
    for_each = {for vpc in var.LIST_VPC_ID : vpc.name => vpc}
  provider = each.value.provider

  vpc_id  = each.value.ID
  zone_id = aws_route53_zone.private-1.id
}

# resource "aws_route53_vpc_association_authorization" "main-2" {
#   vpc_id  = var.TESTING_VPC_ID
#   zone_id = var.DNS_PHZ_ID
# }
# resource "aws_route53_vpc_association_authorization" "main-3" {
#   vpc_id  = var.PROD_VPC_ID
#   zone_id = var.DNS_PHZ_ID
# }
# resource "aws_route53_vpc_association_authorization" "main-4" {
#   vpc_id  = var.PREPROD_VPC_ID
#   zone_id = var.DNS_PHZ_ID
# }
# resource "aws_route53_vpc_association_authorization" "main-5" {
#   vpc_id  = var.EDGE_PROD_VPC_ID
#   zone_id = var.DNS_PHZ_ID
# }
# resource "aws_route53_vpc_association_authorization" "main-6" {
#   vpc_id  = var.EDGE_PROD_VPC_ID
#   zone_id = var.DNS_PHZ_ID
# }
# resource "aws_route53_zone_association" "example" {
# #   provider = "aws.alternate"

#   vpc_id  = var.NETWORK_VPC_ID
#   zone_id = var.DNS_PHZ_ID
# }
# resource "aws_route53_zone_association" "link-1" {
#   provider = "aws.network"

#   vpc_id  = var.LIST_VPC_ID[1].ID
#   zone_id = aws_route53_zone.private-1.id
# }

