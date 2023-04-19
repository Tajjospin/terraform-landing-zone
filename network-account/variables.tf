
variable "profile-name" {
    description = "local aws profile name"
    type = string
    default = "cno-sso"
}
# variable "flow-log-bucket" {
#     description = "bucket of all flow log in Log Archive account"
#     type = string
#     default = "arn:aws:s3:::terraform-logs-tests"/AWSLogs/account_id/vpcflowlogs/region/year/month/day/
  
# }

variable "aws-region" {
    description = "define region to deploy"
    type = string
    default = "eu-west-1"
  
}
variable "vpc-cidr" {
    description = "IP address range of VPC"
    type = string
    default = "10.120.0.0/16"
}

variable "vpc-name" {
    description = "name of VPC"
    type = string
    default = "Hub-network"
  
}

variable "sub-priv-1-cidr" {
    description = "IP address range of private subnet of availabilty zone a"
    type = string
    default = "10.120.2.0/24"
}

variable "sub-priv-2-cidr" {
    description = "IP address range of private subnet of availabilty zone b"
    type = string
    default = "10.120.6.0/24"
}

variable "sub-priv-3-cidr" {
    description = "IP address range of private subnet of availabilty zone c"
    type = string
    default = "10.120.10.0/24"
}
variable "sub-pub-1-cidr" {
    description = "IP address range of public subnet of availabilty zone a"
    type = string
    default = "10.120.0.0/24"
}

variable "sub-pub-2-cidr" {
    description = "IP address range of public subnet of availabilty zone b"
    type = string
    default = "10.120.4.0/24"
}

variable "sub-pub-3-cidr" {
    description = "IP address range of public subnet of availabilty zone c"
    type = string
    default = "10.120.8.0/24"
}
variable "network-igw-name" {
    description = "the name tag of internet gateway"
    default = "igw-hub-network"
    type = string
}

variable "shared-vpc-cidr-block" {
    description = "CIDR of vpc of network account"
    type = string 
    default = "10.122.0.0/16"
}
variable "testing-vpc-cidr-block" {
    description = "CIDR of vpc of network account"
    type = string 
    default = "10.130.0.0/16"
}


variable "testing-account-id" {
    description = "the ID of aws testing account that we want to associate"
    type = string
    default = "182862085962"
}

########## transit gateway attachment of different account

variable "tgw-attach-testing-id" {
    description = "ID of transit gateway attachment of testing account"
    type = string
    default = "tgw-attach-0e8b9a9d4d8416277"
}

# variable "tgw-attach-edge-id" {
#     description = "ID of transit gateway attachment of edge account"
#     type = string
#     default = ""
# }
