

# call network module
module "network" {
    source = "./modules/network"
    vpc-name = var.vpc-name
    vpc-cidr = var.vpc-cidr
    sub-priv-1-cidr = var.sub-priv-1-cidr
    sub-priv-2-cidr = var.sub-priv-2-cidr
    sub-priv-3-cidr = var.sub-priv-3-cidr
    sub-pub-1-cidr = var.sub-pub-1-cidr
    sub-pub-2-cidr = var.sub-pub-2-cidr
    sub-pub-3-cidr = var.sub-pub-3-cidr
    # flow-log-bucket = var.flow-log-bucket
}



#call transit module

module "transit" {
    source = "./modules/transit"
    network-vpc-id = module.network.vpc-id
    network-vpc-cidr-block = module.network.vpc-cidr-block
    sub-network-attach-id = [
        module.network.priv-subnet-1-id,
        module.network.priv-subnet-2-id,
        module.network.priv-subnet-3-id
    ]
    # tgw-attach-testing-id = var.tgw-attach-testing-id
    # tgw-attach-edge-id = var.tgw-attach-edge-id
    # flow-log-bucket = var.flow-log-bucket

    depends_on = [
      module.network
    ]
  
}

module "RAM" {
  source = "./modules/ram"
  testing-account-id = var.testing-account-id
  # transit-arn = module.transit.tgw-arn
  LIST_ARN = [
        module.transit.tgw-arn, 
        module.network.pub-subnet-1-arn,
        module.network.pub-subnet-2-arn,
        module.network.pub-subnet-3-arn]

  depends_on = [
    module.transit
  ]
}

# call gateway module

module "gateway" {
    source = "./modules/gateway"
    network-vpc-id = module.network.vpc-id
    network-igw-name = var.network-igw-name
    sub-pub-1-id = module.network.pub-subnet-1-id
    sub-pub-2-id = module.network.pub-subnet-2-id
    sub-pub-3-id = module.network.pub-subnet-3-id
    sub-priv-1-id = module.network.priv-subnet-1-id
    sub-priv-2-id = module.network.priv-subnet-2-id
    sub-priv-3-id = module.network.priv-subnet-3-id
    shared-vpc-cidr-block = var.shared-vpc-cidr-block
    testing-vpc-cidr-block = var.testing-vpc-cidr-block
    transit-gateway-id = module.transit.tgw-id

    depends_on = [
      module.transit
    ]

}
