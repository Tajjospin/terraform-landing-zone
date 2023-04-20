variable "profile" {
  description = "the terraform user profile"
  type        = string
  default     = "cno-sso"
}
variable "aws-region" {
  type    = string
  default = "eu-west-1"
}
variable "vpn-endpoint-id" {
  description = "ID of existing VPN"
  type        = string
  default     = "cvpn-endpoint-029f6906aed14ba70"
}
variable "vpn-subnet-id" {
  description = "ID of existiing subnet for vpn trafic"
  type        = string
  default     = "subnet-0144f9b4630a20657"
}
variable "lz-vpc-cidr" {
  description = "list of VPC name and cidr"
  type = list(object({
    name = string
    cidr = string
  }))

  default = [{
    name = "myriad-network"
    cidr = "10.120.0.0/16"
    },
    {
      name = "myriad-prod"
      cidr = "10.124.0.0/16"
    },
    {
      name = "myriad-preprod"
      cidr = "10.126.0.0/16"
    },
    {
      name = "myriad-testing"
      cidr = "10.130.0.0/16"
    },
    {
      name = "myriad-shared"
      cidr = "10.122.0.0/16"
  }]
}
