
# création d'un rôle IAM pour avoir les droits de gestion du service EC2

resource "aws_iam_role" "eks-nodes-role" {
  name = "${var.node-grp-name}-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-nodes-role.name
}

resource "aws_iam_role_policy_attachment" "eks-nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-nodes-role.name
}

resource "aws_iam_role_policy_attachment" "eks-nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-nodes-role.name
}


#création des noeuds du cluster (les workers)

resource "aws_eks_node_group" "eks-nodes" {
  cluster_name    = var.cluster_name
  node_group_name = var.node-grp-name
  node_role_arn   = aws_iam_role.eks-nodes-role.arn
  subnet_ids      = var.subnet_ids

  capacity_type = var.node_capacity_type
  instance_types = [var.TYPE_EC2]
  disk_size = var.ESPACE_DISK


  scaling_config {
    desired_size = var.node_desire
    max_size     = var.node_max
    min_size     = var.node_min
  }

  update_config {
    max_unavailable = 1
  }

   labels = {
    "role" = "general"
  }

 
  # S'assurer que les permissions des rôles IAM sont créées avant et supprimées après le groupe de noeuds
  # Si non, EKS ne pourra pas supprimer les instances EC2 les loadbalancer proprement

  depends_on = [
    aws_iam_role_policy_attachment.eks-nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-nodes-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    "Name" = var.node-grp-name
  }


}