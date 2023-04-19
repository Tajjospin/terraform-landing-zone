output "arn_role" {
    description = "afficher l ARN du role "
    value = aws_iam_role.cross_account_assume_role.arn
  
}

output "nom_utilisateur" {
    description = "afficher le nom du user cree "
    value = aws_iam_user.utilisateur.name
}
output "Access_key_id" {
  value = aws_iam_access_key.clef_access.id
}

output "Access_key_secret" {
  value = nonsensitive(aws_iam_access_key.clef_access.secret)
}


