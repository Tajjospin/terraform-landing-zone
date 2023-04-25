variable "AWS_REGION" {
  type    = string
  default = "eu-west-1"
}
variable "profile-1" {
  type    = string
  default = "jospin-root"
}
variable "profile-2" {
  type    = string
  default = "jospin-log"

}
# variable "AWS_ACCESS_KEY_TESTING" {}
# variable "AWS_SECRET_KEY_TESTING" {}

# variable "AWS_ACCESS_KEY_NETWORK" {}
# variable "AWS_SECRET_KEY_NETWORK" {}


variable "PRIV_DOMAIN_NAME_1" {
  description = "domain name of hosted zone"
  type        = string
  default     = "anogo.taj"
}
variable "SHARED_VPC_ID" {
  description = "VPC ID of shared services account"
  type        = string
  default     = "vpc-0db4496aff868b93d"
}

variable "LIST_RECORD" {
  description = "list of all DNS record "
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  default = [{
    name    = "project.anogo.taj"
    records = ["10.1.20.169"]
    ttl     = 300
    type    = "A"
  }]

}


variable "LIST_VPC_ID" {
  description = "list of all vpc "
  type = list(object({
    name     = string
    ID       = string
  }))

  default = [
    {
      name     = "jospin-log-vpc-id"
      ID       = "vpc-0b25c719580386ba2"
    },
    {
      name     = "vpc-log-id"
      ID       = "vpc-06ec60ee43057081f"
    }
  ]
}
variable "NETWORK_VPC_IDs" {
  description = "list of all vpc "
  type = list(object({
    name     = string
    ID       = string
  }))

  default = [
    {
      name     = "jospin-log-vpc-id"
      ID       = "vpc-0b25c719580386ba2"
    },
    {
      name     = "vpc-log-id"
      ID       = "vpc-06ec60ee43057081f"
    }
  ]
}
