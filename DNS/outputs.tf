# output "dns-association-id" {
#     value = aws_route53_vpc_association_authorization.example.id
# }
output "vpc-associate-dns-id" {
    value = aws_route53_zone_association.example.id
}
# output "dns-tesing-associate-id" {
#     value = aws_route53_vpc_association_authorization.example.id
# }