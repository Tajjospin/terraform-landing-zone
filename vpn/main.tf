############ VPN authorizations ###############

resource "aws_ec2_client_vpn_authorization_rule" "vpn-auth" {
  for_each               = { for vpc in var.lz-vpc-cidr : vpc.name => vpc }
  client_vpn_endpoint_id = var.vpn-endpoint-id
  target_network_cidr    = each.value.cidr
  authorize_all_groups   = true
  description = each.value.name
}

############ VPN route to transit gateway #######

resource "aws_ec2_client_vpn_route" "vpn-rte" {
  for_each               = { for vpc in var.lz-vpc-cidr : vpc.name => vpc }
  client_vpn_endpoint_id = var.vpn-endpoint-id
  destination_cidr_block = each.value.cidr
  target_vpc_subnet_id   = var.vpn-subnet-id
  description = each.value.name
}