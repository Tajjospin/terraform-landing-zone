output "tgw-attach-id-1" {
    description = "ID of the transit gateway attachment of VPC-1"
    value = aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach.id
}
output "new-route-table" {
  description = "ID of the new routing table"
  value       = aws_route_table.tgw-route-1.id
}
output "subnet-attach" {
  description = "ID of new subnets attachment"
  value = [
    for az, subnet in aws_subnet.sub-priv-1 : subnet.id
  ]
}