variable "network-vpc-id" {
    description = "ID of vpc that will be associated"
    type = string
}
variable "network-vpc-cidr-block" {
    description = "Ip range of vpc to network account"
    type = string
  
}
# variable "flow-log-bucket" {
#     description = "bucket of all flow log in Log Archive account"
#     type = string
  
# }
variable "sub-network-attach-id" {
    description = "subnets id of all availability zone for network attachment"
    type = list(string)
  
}

########## transit gateway attachment of others accounts
variable "tgw-attach-testing-id" {
    description = "ID of transit gateway attachment of testing account"
    type = string
}
variable "tgw-attach-edge-id" {
    description = "ID of transit gateway attachment of edge account"
    type = string
}