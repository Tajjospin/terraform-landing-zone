
resource "aws_iam_user" "utilisateur" {
  name = var.nom_utilisateur
  path = "/"
}

resource "aws_iam_access_key" "clef_access" {
  user = aws_iam_user.utilisateur.name
  #pgp_key = "keybase:terraform-user"
}


data "aws_iam_policy_document" "cross_account_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
    #   identifiers = var.principal_arns
      identifiers = [aws_iam_user.utilisateur.arn]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cross_account_assume_role" {
  name               = var.nom_role
  assume_role_policy = data.aws_iam_policy_document.cross_account_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "cross_account_assume_role" {
  count = length(var.policy_arns)

  role       = aws_iam_role.cross_account_assume_role.name
  policy_arn = element(var.policy_arns, count.index)
}

