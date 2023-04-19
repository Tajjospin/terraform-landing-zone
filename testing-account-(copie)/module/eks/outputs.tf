output "endpoint_cluster" {
    description = "end point of cluster"
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "Cluster_name" {
    description = "name du cluster"
    value = aws_eks_cluster.eks-cluster.name
}

output "Cluster_id" {
  description = "cluster ID"
  value = aws_eks_cluster.eks-cluster.id
  
}