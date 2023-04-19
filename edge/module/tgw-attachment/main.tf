
# # create the transit gateway attachment subnets

# resource "aws_subnet" "sub-priv-1" {
#   for_each               = { for subnet in slice(var.list-sub-priv, 0, 3) : subnet.name => subnet }
#   vpc_id     = var.vpc-tgw-attach.vpc_id
#   cidr_block = each.value.cidr
#   availability_zone = "${var.aws-region}${each.value.az}"
#   tags = {
#     Name = each.value.name
#   }
# }

# ####create the transit gateway attachment

# resource "aws_ec2_transit_gateway_vpc_attachment" "network-vpc-attach" {
#   subnet_ids         = [ 
#     for az, subnet in aws_subnet.sub-priv-1 : subnet.id
#   ]
#   transit_gateway_id = var.transit-network-id
#   vpc_id             = var.vpc-tgw-attach.vpc_id

#   tags = {
#     "Name" = var.vpc-tgw-attach.tgw_name
#   }
# }

# #### create routing table to transit gateway
# resource "aws_route_table" "tgw-route-1" {
#   vpc_id = var.vpc-tgw-attach.vpc_id
#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = var.vpc-tgw-attach.nat_id
#   }

#   tags = {
#     Name = "attach-routing-table-${var.vpc-tgw-attach.vpc_name}"
#   }
#   depends_on = [
#     aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach
#   ]
# }
# resource "aws_route" "routes" {
#   for_each               = { for vpc in slice(var.lz-vpc-cidr, 0, 5) : vpc.name => vpc }
#   route_table_id         = aws_route_table.tgw-route-1.id
#   destination_cidr_block = each.value.cidr
#   transit_gateway_id     = var.transit-network-id
# }

# # Liaison de la table de routage ci dessus au réseau privé de l'AZ-A
# resource "aws_route_table_association" "association-private-subnet-1" {
#   for_each               = { for subnet in slice(var.list-sub-priv, 0, 3) : subnet.name => subnet }
#   subnet_id = aws_subnet.sub-priv-1[each.key].id
#   route_table_id = aws_route_table.tgw-route-1.id
# }


#### create the transit gateway attachment subnets

resource "aws_subnet" "sub-priv-1" {
  for_each          = { for subnet in var.list-sub-priv : subnet.name => subnet }
  vpc_id            = var.vpc-tgw-attach.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = "${var.aws-region}${each.value.az}"
  tags = {
    Name = each.value.name
  }
}

#### create the transit gateway attachment

resource "aws_ec2_transit_gateway_vpc_attachment" "network-vpc-attach" {
  subnet_ids = [
    for az, subnet in aws_subnet.sub-priv-1 : subnet.id
  ]
  transit_gateway_id = var.transit-network-id
  vpc_id             = var.vpc-tgw-attach.vpc_id

  tags = {
    "Name" = var.vpc-tgw-attach.tgw_name
  }
}
#### create routing table to transit gateway
resource "aws_route_table" "tgw-route-1" {
  vpc_id = var.vpc-tgw-attach.vpc_id

  tags = {
    Name = "attach-routing-table-${var.vpc-tgw-attach.vpc_name}"
  }
  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach
  ]
}
resource "aws_route" "routes" {
  for_each               = { for vpc in var.lz-vpc-cidr : vpc.name => vpc }
  route_table_id         = aws_route_table.tgw-route-1.id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = var.transit-network-id
}

#### Liaison de la table de routage ci dessus aux sous réseau privé 
resource "aws_route_table_association" "association-private-subnet-1" {
  for_each       = { for subnet in var.list-sub-priv : subnet.name => subnet }
  subnet_id      = aws_subnet.sub-priv-1[each.key].id
  route_table_id = aws_route_table.tgw-route-1.id
}

##################### ADD transit route in existing routing tables ################################

resource "aws_route" "routes-1" {
  for_each               = { for vpc in var.lz-vpc-cidr : vpc.name => vpc }
  route_table_id         = var.route1_table_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = var.transit-network-id
  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach
  ]
}
resource "aws_route" "routes-2" {
  for_each               = { for vpc in var.lz-vpc-cidr : vpc.name => vpc }
  route_table_id         = var.route2_table_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = var.transit-network-id
  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach
  ]
}