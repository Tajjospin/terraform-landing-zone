provider "aws" {
    # define region to deploy
    region = var.aws-region
    profile = var.profile-name

}

terraform {

#define organization and workspace of terraform cloud  
  # cloud {
  #   organization = "myriadgroup"

  #   workspaces {
  #     name = "workload-testing"
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
