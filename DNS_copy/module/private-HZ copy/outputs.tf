
output "dn-associate-id" {
  value = [for dn, dns in aws_route53_vpc_association_authorization.main : dns.id]
}
output "vpc-associate-dns-id" {
  value = [
    for az, as in aws_route53_zone_association.link : as.id
  ]
}

output "hosted-zone" {
  value = aws_route53_zone.private-1.id
}
output "record" {
  value = [
    for az, as in aws_route53_record.record-1 : as.records
  ]
}