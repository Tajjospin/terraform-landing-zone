output "vpc-id" {
    value = module.network.vpc-id
}

output "vpc-cidr-block" {
    description = "ip address range of VPC"
    value = module.network.vpc-cidr-block
}
output "priv-subnet-1" {
    description = "ip address range of private subnet 1 AZ-a"
    value = module.network.priv-subnet-1
}
output "priv-subnet-2" {
    description = "ip address range of private subnet 1 AZ-b"
    value = module.network.priv-subnet-2
}
output "priv-subnet-3" {
    description = "ip address range of private subnet 1 AZ-c"
    value = module.network.priv-subnet-3
}
output "public-subnet-1" {
    description = "ip address range of private subnet 1 AZ-a"
    value = module.network.pub-subnet-1
}
output "public-subnet-2" {
    description = "ip address range of private subnet 1 AZ-b"
    value = module.network.pub-subnet-2
}
output "public-subnet-3" {
    description = "ip address range of private subnet 1 AZ-c"
    value = module.network.pub-subnet-3
}
output "tgw-id" {
    description = "ID of transit gateway"
    value = module.transit.tgw-id
}
output "tgw-network-attach" {
    description = "ID of transit gateway attachement of network account"
    value = module.transit.tgw-network-attach
  
}
output "tgw-NET-SHAR-route" {
    description = "ID of transit gateway routing table to network and shared accounts"
    value = module.transit.tgw-NET-SHAR-route
  
}
output "tgw-TESTING-route" {
    description = "ID of transit gateway routing table to network and shared accounts"
    value = module.transit.tgw-TESTING-route
  
}
output "tgw-Edge-route" {
    description = "ID of transit gateway routing table to network and shared accounts"
    value = module.transit.tgw-Edge-route
  
}
# output "flow-log-transit" {
#     description = "the flow logs of transit gateway"
#     value = module.transit.flow-log-transit
  
# }
# output "flow-log-transit-destination" {
#     description = "the flow logs of transit gateway"
#     value = module.transit.flow-log-transit-destination
  
# }
# output "flow-log-network-vpc" {
#     description = "the flow logs of transit gateway"
#     value = module.network.flow-log-network-vpc
  
# }
output "transit-ram-name" {
    description = "the name of RAM that shares the transit gateway"
    value = module.RAM.transit-ram-name
}