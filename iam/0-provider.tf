provider "aws" {
    region = var.AWS_REGION
    # Préciser le profile correspondant à l'utilisateur qui doit exécuter le code
    profile = var.AWS_PROFILE

    assume_role {
    # Préciser le role que le profil doit assumer pour exécuter les actions
    role_arn    = "arn:aws:iam::731532231685:role/terraform-eks-poc-role"
   
  }
}

terraform {
  # préciser le bucket qui contiendra le fichier d'état
  # backend "s3" {
  #   bucket = "myriad-poc-eks"
  #   key    = "terraform.tfstate"
  #   region = "eu-west-3"
  #   profile = "myriad-iac"
  #   role_arn    = "arn:aws:iam::731532231685:role/terraform-eks-poc-role"
  # }

# préciser la version de l'API à utiliser
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}