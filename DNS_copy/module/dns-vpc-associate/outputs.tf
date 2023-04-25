

output "vpc-associate-dns-id" {
  value = [
    for az, as in aws_route53_zone_association.link : as.id
  ]
}
