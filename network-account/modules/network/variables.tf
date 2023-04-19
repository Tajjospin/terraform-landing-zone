
variable "aws-region" {
    description = "define region to deploy"
    type = string
    default = "eu-west-1"
  
}
# variable "flow-log-bucket" {
#     description = "bucket of all flow log in Log Archive account"
#     type = string
  
# }
variable "vpc-cidr" {
    description = "IP address range of VPC"
    type = string
    default = "10.0.0.0/16"
}

# variable "network-ipv6-cidr" {
#     description = "IP address range of VPC"
#     type = string
#     default = "2002:120::/56"
# }

variable "sub-priv-1-cidr" {
    description = "IP address range of private subnet of availabilty zone a"
    type = string
    default = "10.0.0.0/24"
}
variable "sub-priv-2-cidr" {
    description = "IP address range of private subnet of availabilty zone b"
    type = string
    default = "10.0.2.0/24"
}

variable "sub-priv-3-cidr" {
    description = "IP address range of private subnet of availabilty zone c"
    type = string
    default = "10.0.4.0/24"
}
variable "vpc-name" {
    description = "name of VPC"
    type = string
    default = "main"
  
}

variable "sub-pub-1-cidr" {
    description = "IP address range of pub subnet of availabilty zone a"
    type = string
    default = "10.0.6.0/24"
}
variable "sub-pub-2-cidr" {
    description = "IP address range of pub subnet of availabilty zone b"
    type = string
    default = "10.0.8.0/24"
}

variable "sub-pub-3-cidr" {
    description = "IP address range of public subnet of availabilty zone c"
    type = string
    default = "10.0.10.0/24"
}