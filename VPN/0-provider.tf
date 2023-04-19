provider "aws" {
    # define region to deploy
    region = var.aws-region
    profile = var.profile
  #   assume_role {
  #   # Préciser le role que le profil doit assumer pour exécuter les actions
  #   role_arn    = "arn:aws:iam::532930110756:role/terraform-role"
   
  # }

}

terraform {
# define aws api version
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}
