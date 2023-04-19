
module "mu-prod" {
  source             = "./module/tgw-attachment"
  vpc-tgw-attach     = var.vpc-tgw-attach-mu-prod
  list-sub-priv      = var.list-sub-priv-mu-prod
  transit-network-id = var.transit-network-id
  route1_table_id    = var.mu1-route_table_id
  route2_table_id    = var.mu2-route_table_id
}
###############################################
#                                             #
##################### Ajout des routes inter VPC dans MU PROD VPC ##################################
#                                             #
###############################################

resource "aws_route" "mu-1" {
  route_table_id         = module.mu-prod.new-route-table
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.vpc-tgw-attach-mu-prod.nat_id
  depends_on             = [module.mu-prod]
}
resource "aws_route" "mu-2" {
  for_each               = { for vpc in slice(var.vpc-edge-cidr, 0, 2) : vpc.name => vpc }
  route_table_id         = module.mu-prod.new-route-table
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = var.transit-network-id
  depends_on             = [module.mu-prod]
}
resource "aws_route" "mu-3" {
  for_each               = { for vpc in slice(var.vpc-edge-cidr, 0, 2) : vpc.name => vpc }
  route_table_id         = var.mu1-route_table_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = var.transit-network-id
  depends_on             = [module.mu-prod]
}
resource "aws_route" "mu-4" {
  for_each               = { for vpc in slice(var.vpc-edge-cidr, 0, 2) : vpc.name => vpc }
  route_table_id         = var.mu2-route_table_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = var.transit-network-id
  depends_on             = [module.mu-prod]
}