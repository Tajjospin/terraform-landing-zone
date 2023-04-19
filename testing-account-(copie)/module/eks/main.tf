

# create an IAM role to give permission at EKS service

resource "aws_iam_role" "cluster-role" {
  name = var.nom-cluster

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


#link the role with permissions on the cluster
resource "aws_iam_role_policy_attachment" "cluster-role-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster-role.name
}

# activte a security groups for the ressources that EKS managed
resource "aws_iam_role_policy_attachment" "cluster-role-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster-role.name
}

#create the cluster

resource "aws_eks_cluster" "eks-cluster" {
  name     = var.nom-cluster
  role_arn = aws_iam_role.cluster-role.arn

  vpc_config {
    subnet_ids = var.subnet
  }

 
  depends_on = [
    aws_iam_role_policy_attachment.cluster-role-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster-role-AmazonEKSVPCResourceController,
  ]
}

# configuration of certificat tls

data "tls_certificate" "eks-tls" {
  url = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks-openid-connect" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks-tls.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "eks-policy-doc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks-openid-connect.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks-openid-connect.arn]
      type        = "Federated"
    }
  }
}