provider "aws" {
  # define region to deploy
  region  = var.AWS_REGION
  profile = var.profile-1
}


provider "aws" {
  region  = var.AWS_REGION
  alias   = "network"
  profile = var.profile-2
}
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
      configuration_aliases = [ aws.alternate ]
    }
  }
}
