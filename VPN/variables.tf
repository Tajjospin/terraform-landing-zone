variable "domain" {
    description = "domain name to vpn access"
    type = string
    default = "taj-test" 
}

variable "subnet-id" {
    description = "all subnet to vpc"
    type = string
    default = "subnet-0144f9b4630a20657"
  
}

variable "vpc-cidr-block" {
    description = "the cidr of vpc that we link vpn"
    type = string
    default = "10.2.0.0/16"
}

variable "profile" {
    description = "the terraform user profile"
    type = string
    default = "cno-sso"
}
variable "saml-provide-arn" {
    description = "the ARN of the saml provider "
    type = string
    default = "arn:aws:iam::370953620355:saml-provider/AWSSSO_d0f3467c2d61a1ef_DO_NOT_DELETE"
}

variable "self-samlprovide-arn" {
    description = "the ARN of the self saml provider "
    type = string
    default = "arn:aws:iam::370953620355:saml-provider/AWSSSO_d0f3467c2d61a1ef_DO_NOT_DELETE"
}
variable "aws-region" {
    type = string
    default = "eu-west-1"
}

variable "vpc-id" {
    type = string
    default = "vpc-0ada8bab2ed945d7d"
}