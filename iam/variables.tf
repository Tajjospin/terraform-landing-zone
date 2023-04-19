
variable "AWS_PROFILE" {
    description = "détermine le profile AWS CLI configuré en local"
    type = string
    default = "myriad-iac"
}

variable "AWS_REGION" {
  description = "c'est la région où l'infra sera déployée"
  type = string
  default = "eu-west-3"
}



variable "nom_role" {
  default = "taj_role"
  type        = string
  description = "The name of the role. "
}
# variable "principal_arns" {
#   default = ["123456789012"]
#   type        = list(string)
#   description = "ARNs of accounts, groups, or users with the ability to assume this role."
# }

variable "policy_arns" {
  default = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess",
             "arn:aws:iam::aws:policy/IAMFullAccess",
             "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
             "arn:aws:iam::731532231685:policy/eks-full-access",
             "arn:aws:iam::731532231685:policy/s3-allowAll"
            ]
  type        = list(string)
  description = "List of ARNs of policies to be associated with the created IAM role"
}
variable "nom_utilisateur" {
  default = "taj_user"
  type        = string
  description = "The name of the iam user. "
}
