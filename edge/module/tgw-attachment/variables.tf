variable "aws-region" {
  description = "AWS region where to deploy infrastructures"
  type        = string
  default     = "eu-west-1"
}
variable "vpc-tgw-attach" {
  description = "VPC name and transit gateway attachment name"
  type = object({
    vpc_name = string
    vpc_id   = string
    tgw_name = string
    nat_id   = string
  })

}
variable "list-sub-priv" {
  description = "list of private subnets name and cidr"
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))

}
variable "route1_table_id" {
  description = "ID of existing public routing table"
  type        = string
}
variable "route2_table_id" {
  description = "ID of existing public routing table"
  type        = string
}
######################## VPC list of different accounts  #######################

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

variable "transit-network-id" {
  description = "ID of transit gateway shared by the myriad-network account"
  type        = string
  default     = "tgw-09ac7dc720a70f46f"
}
