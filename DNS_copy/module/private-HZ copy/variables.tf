variable "PRIV_DOMAIN_NAME_1" {
  description = "domain name of hosted zone"
  type        = string
}
variable "SHARED_VPC_ID" {
  description = "VPC ID of shared services account"
  type        = string
  default     = ""
}

variable "LIST_RECORD" {
  description = "list of all DNS record "
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))

}


variable "LIST_VPC_ID" {
  description = "list of all vpc "
  type = list(object({
    name     = string
    ID       = string
    provider = string
  }))

  default = [
    {
      name     = "network-vpc-id"
      ID       = ""
      provider = "aws.network"
    },
    {
      name     = "testing-vpc-id"
      ID       = ""
      provider = "aws.testing"
    }
  ]
}
