variable "network-vpc-id" {
    description = "ID of vpc that will be associated"
    type = string
}

variable "network-igw-name" {
    description = "the name tag of internet gateway"
    default = "igw-hub-network"
    type = string
}

variable "sub-pub-1-id" {
    description = "ID of public subnet of AZ-a"
    type = string
}
variable "sub-pub-2-id" {
    description = "ID of public subnet of AZ-b"
    type = string
}
variable "sub-pub-3-id" {
    description = "ID of public subnet of AZ-c"
    type = string
}

variable "sub-priv-1-id" {
    description = "ID of private subnet of AZ-a"
    type = string
}
variable "sub-priv-2-id" {
    description = "ID of private subnet of AZ-b"
    type = string
}
variable "sub-priv-3-id" {
    description = "ID of private subnet of AZ-c"
    type = string
}


####################### CIDR of different account

variable "testing-vpc-cidr-block" {
    description = "CIDR of vpc of testing account"
    type = string 
}

variable "shared-vpc-cidr-block" {
    description = "CIDR of vpc of shared services account"
    type = string 
}

################ ID of transit gateway

variable "transit-gateway-id" {
    description = "ID of transit gateway of network account"
    type = string 
}
