output "tgw-id" {
    description = "ID of transit gateway"
    value = aws_ec2_transit_gateway.tgw.id
  
}
output "tgw-arn" {
    description = "ID of transit gateway"
    value = aws_ec2_transit_gateway.tgw.arn
  
}
output "tgw-asn" {
    description = "Private Autonomous System Number of transite gateway"
    value = aws_ec2_transit_gateway.tgw.amazon_side_asn
}

output "tgw-network-attach" {
    description = "ID of transit gateway attachement of network account"
    value = aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach.id
  
}
output "tgw-NET-SHAR-route" {
    description = "ID of transit gateway routing table to network and shared accounts"
    value = aws_ec2_transit_gateway_route_table.tgw-NET-SHAR-route-table.id
  
}
output "tgw-TESTING-route" {
    description = "ID of transit gateway routing table to network and shared accounts"
    value = aws_ec2_transit_gateway_route_table.tgw-TESTING-route-table.id
  
}
output "tgw-Edge-route" {
    description = "ID of transit gateway routing table to network and shared accounts"
    value = aws_ec2_transit_gateway_route_table.tgw-Edge-route-table.id
  
}
# output "flow-log-transit" {
#     description = "the flow logs of transit gateway"
#     value = aws_flow_log.flow-logs.id
  
# }
# output "flow-log-transit-destination" {
#     description = "the flow logs of transit gateway"
#     value = aws_flow_log.flow-logs.log_destination
  
# }