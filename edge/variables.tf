variable "aws-region" {
  description = "AWS region where to deploy infrastructures"
  type        = string
  default     = "eu-west-1"
}
variable "profile-name" {
  type    = string
  default = "cno-sso"

}
variable "vpc-tgw-attach-mu-prod" {
  description = "VPC name and transit gateway attachment name"
  type = object({
    vpc_name = string
    vpc_id   = string
    tgw_name = string
    nat_id   = string
  })

  default = {
    tgw_name = "tgw-attach-edge-mu-prod"
    vpc_id   = "vpc-067d51f54371a6d07"
    vpc_name = "test"
    nat_id   = "nat-0529e2891b2495c28"
  }
}
variable "list-sub-priv-mu-prod" {
  description = "list of private subnets name and cidr"
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))

  default = [{
    name = "mup-sub-1"
    cidr = "10.23.20.0/28"
    az   = "a"
    },
    {
      name = "mup-sub-2"
      cidr = "10.23.20.16/28"
      az   = "b"
    },
    {
      name = "mup-sub-3"
      cidr = "10.23.20.32/28"
      az   = "c"
  }]

}

variable "transit-network-id" {
  description = "ID of transit gateway shared by the myriad-network account"
  type        = string
  default     = "tgw-0523df11fca0616fc"
}

variable "vpc-edge-cidr" {
  description = "list of private subnets name and cidr"
  type = list(object({
    name = string
    cidr = string
  }))

  default = [{
    name = "hub-preprod"
    cidr = "10.135.0.0/16"
    },
    {
      name = "hub-prod"
      cidr = "10.134.0.0/16"
    },
    {
      name = "mu-prod"
      cidr = "10.132.0.0/16"
  }]

}
variable "mu1-route_table_id" {
  description = "ID of MU PROD other routing table"
  type        = string
  default     = "rtb-062c5e2d58e06ef11"
}
variable "mu2-route_table_id" {
  description = "ID of MU PROD main routing table"
  type        = string
  default     = "rtb-07d1ba25d298b22cc"
}