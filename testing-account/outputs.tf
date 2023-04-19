output "vpc-id" {
    value = module.network.vpc-id
}

output "vpc-cidr-block" {
    description = "ip address range of VPC"
    value = module.network.vpc-cidr-block
}
output "priv-subnet-1" {
    description = "ip address range of private subnet 1 AZ-a"
    value = module.network.priv-subnet-1
}
output "priv-subnet-1-id" {
    description = "ID of private subnet 1 AZ-a"
    value = module.network.priv-subnet-1-id
}
output "priv-subnet-2" {
    description = "ip address range of private subnet 1 AZ-b"
    value = module.network.priv-subnet-2
}
output "priv-subnet-2-id" {
    description = "ID of private subnet 1 AZ-b"
    value = module.network.priv-subnet-2-id
}
output "priv-subnet-3" {
    description = "ip address range of private subnet 1 AZ-c"
    value = module.network.priv-subnet-3
}
output "priv-subnet-3-id" {
    description = "ID of private subnet 1 AZ-c"
    value = module.network.priv-subnet-3-id
}

output "flow-log-network-vpc" {
    description = "the flow logs of transit gateway"
    value = module.network.flow-log-network-vpc
  
}
output "tgw-network-attach" {
    description = "ID of transit gateway attachement of network account"
    value = module.network.tgw-network-attach
  
}
 output "cluster_name" {
   description = "name of the EKS cluster name"
   value = module.cluster_eks.Cluster_name
 }
 output "cluster-endpoint" {
     value = module.cluster_eks.endpoint_cluster
 }
