# call vpc module

module "network" {
    source = "./module/vpc"
    vpc-name = var.vpc-name
    vpc-cidr = var.vpc-cidr
    sub-priv-cidr = var.sub-priv-cidr
    # sub-priv-1-cidr = var.sub-priv-1-cidr
    # sub-priv-2-cidr = var.sub-priv-2-cidr
    # sub-priv-3-cidr = var.sub-priv-3-cidr
    cluster-name = var.nom-cluster
    transit-network-id = var.transit-network-id
    flow-log-bucket = var.flow-log-bucket
  
}

module "cluster_eks" {
    source = "./module/eks"
    nom-cluster = var.nom-cluster
    vpc-testing-id =module.network.vpc-id
    subnet = slice(var.sub-priv-cidr, 0, 3)
    
    depends_on = [
      module.network
    ]
}
module "node_cluster" {
    source = "./module/nodes"
    node-grp-name = var.node-grp-name
    cluster_name = module.cluster_eks.Cluster_name
    subnet_ids = var.sub-priv-cidr
    TYPE_EC2 = var.type-ec2
    node_capacity_type = var.node_capacity_type
    ESPACE_DISK = var.espace-disk
    node_max = var.node_max
    node_desire = var.node_desire
    node_min = var.node_min
    
    depends_on = [
      module.cluster_eks
    ]
}
