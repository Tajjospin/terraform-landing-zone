variable "flow-log-bucket" {
    description = "bucket of all flow log in Log Archive account"
    type = string
  
}
variable "aws-region" {
    description = "define region to deploy"
    type = string
    default = "eu-west-1"
  
}
variable "cluster-name" {
    type = string
    default = "myriad-poc-eks-cluster"
  
}

variable "vpc-cidr" {
    description = "IP address range of VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "sub-priv-cidr" {
    description = "list of IP address range of private subnet"
    type = list(string)
    default = [ "10.0.0.0/24", "10.0.2.0/24", "10.0.4.0/24" ]
}

# variable "sub-priv-1-cidr" {
#     description = "IP address range of private subnet of availabilty zone a"
#     type = string
#     default = "10.0.0.0/24"
# }
# variable "sub-priv-2-cidr" {
#     description = "IP address range of private subnet of availabilty zone b"
#     type = string
#     default = "10.0.2.0/24"
# }

# variable "sub-priv-3-cidr" {
#     description = "IP address range of private subnet of availabilty zone c"
#     type = string
#     default = "10.0.4.0/24"
# }
variable "vpc-name" {
    description = "name of VPC"
    type = string
    default = "main"
  
}

variable "transit-network-id" {
    description = "ID of transit gateway of network account"
    type = string
}

