#### create the firts private hosted zone 
module "HZ_1" {
  source             = "./module/private-HZ"
  PRIV_DOMAIN_NAME_1 = var.PRIV_DOMAIN_NAME_1
  SHARED_VPC_ID      = var.SHARED_VPC_ID
  LIST_RECORD        = var.LIST_RECORD
  LIST_VPC_ID        = var.LIST_VPC_ID

}

module "NET_ASS_HZ_1" {
  source = "./module/dns-vpc-associate"
  providers = {
    aws = aws.network 
   }
  LIST_VPC_ID = var.NETWORK_VPC_IDs
  DNS_ZONE_ID = module.HZ_1.hosted-zone-id
}