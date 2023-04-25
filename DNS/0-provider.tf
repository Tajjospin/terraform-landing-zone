provider "aws" {
  # define region to deploy
  region  = var.aws-region
  profile = var.profile-name
}
# provider "aws" {
# }

# provider "aws" {
#   alias = "testing"
#   AWS_ACCESS_KEY = var.AWS_ACCESS_KEY_TESTING
#   AWS_SECRET_KEY = var.AWS_SECRET_KEY_TESTING
# }
# provider "aws" {
#   alias = "network"
#   AWS_ACCESS_KEY = var.AWS_ACCESS_KEY_NETWORK
#   AWS_SECRET_KEY = var.AWS_SECRET_KEY_NETWORK
# }
# provider "aws" {
#   alias = "prod"
#   AWS_ACCESS_KEY = var.AWS_ACCESS_KEY_PROD
#   AWS_SECRET_KEY = var.AWS_SECRET_KEY_PROD
# }
# provider "aws" {
#   alias = "preprod"
#   AWS_ACCESS_KEY = var.AWS_ACCESS_KEY_PREPROD
#   AWS_SECRET_KEY = var.AWS_SECRET_KEY_PREPROD
# }
# provider "aws" {
#   alias = "core-it"
#   AWS_ACCESS_KEY = var.AWS_ACCESS_KEY_PREPROD
#   AWS_SECRET_KEY = var.AWS_SECRET_KEY_PREPROD
# }

terraform {

  #define organization and workspace of terraform cloud  
  # cloud {
  #   organization = "myriadgroup"

  #   workspaces {
  #     name = "shared-dns-associate"
  #   }
  # }

  # define aws api version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
