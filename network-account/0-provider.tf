provider "aws" {
    # define region to deploy
    region = var.aws-region
    profile = var.profile-name
  #   assume_role {
  #   # define the role of terraform user
  #   role_arn    = "arn:aws:iam::731532231685:role/terraform-eks-poc-role"
   
  # }
}

terraform {

#define organization and workspace of terraform cloud  
  # cloud {
  #   organization = "myriadgroup"

  #   workspaces {
  #     name = "vpc-hub-network"
  #   }
  # }

# define aws api version
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}
