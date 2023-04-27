# creation of transit gateway

resource "aws_ec2_transit_gateway" "tgw" {
  description = "My TGW shared with several other AWS accounts"
  dns_support = "enable"
  auto_accept_shared_attachments = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  multicast_support = "enable"
  amazon_side_asn = 64531

  tags = {
    Name = "tgw-hub-network"
  }
}

# resource "aws_s3_bucket" "flow-bucket" {
#   bucket = "terraform-vpc-logs-test"
  
# }

###creation of transit flow logs
# resource "aws_flow_log" "flow-logs" {
#   #specify the ARN bucket of log in Logs Archive account 
  
#   # log_destination      = aws_s3_bucket.flow-bucket.arn
#   log_destination      = "${aws_s3_bucket.flow-bucket.arn}/network-transite-gateway/"
#   log_destination_type = "s3"
#   traffic_type         = "ALL"
#   transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#   max_aggregation_interval = 60
#   destination_options {
#     file_format        = "parquet"
#     per_hour_partition = true
#   }
#   depends_on = [
#     aws_ec2_transit_gateway.tgw,
#     aws_ec2_transit_gateway_route_table.tgw-NET-SHAR-route-table
#   ]

#   tags = {
#     "Name" = "flow-log-transit-gateway"
#   }
# }


resource "aws_ec2_transit_gateway_vpc_attachment" "network-vpc-attach" {
  subnet_ids         = var.sub-network-attach-id
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = var.network-vpc-id
  ipv6_support = "enable"

  tags = {
    "Name" = "tgw-attach-hub-network"
  }
}

# resource "aws_ec2_transit_gateway_connect" "network-attachment" {
#   transport_attachment_id = aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach.id
#   transit_gateway_id      = aws_ec2_transit_gateway.tgw.id
# }


#creation of transit routing tables
resource "aws_ec2_transit_gateway_route_table" "tgw-NET-SHAR-route-table" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    "Name" = "tgw-NET-SHAR-route"
  }
}
resource "aws_ec2_transit_gateway_route_table" "tgw-TESTING-route-table" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = {
    "Name" = "tgw-TESTING-route"
  }
}
# resource "aws_ec2_transit_gateway_route_table" "tgw-Edge-route-table" {
#   transit_gateway_id = aws_ec2_transit_gateway.tgw.id

#   tags = {
#     "Name" = "tgw-Edge-route"
#   }
# }

#creation of transit routes
resource "aws_ec2_transit_gateway_route" "tgw-internete-route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-NET-SHAR-route-table.id
}
# resource "aws_ec2_transit_gateway_route" "tgw-network-route" {
#   destination_cidr_block         = var.network-vpc-cidr-block
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-NET-SHAR-route-table.id
# }

# creation of transit gateway association
resource "aws_ec2_transit_gateway_route_table_association" "network-shared" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-NET-SHAR-route-table.id
}



 ######### testing - prod - preprod routes

# resource "aws_ec2_transit_gateway_route" "tgw-TESTING8-route" {
#   destination_cidr_block         = "10.130.0.0/16"
#   blackhole                      = true
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-TESTING-route-table.id
# }
# resource "aws_ec2_transit_gateway_route" "tgw-TESTING7-route" {
#   destination_cidr_block         = "10.124.0.0/16"
#   blackhole                      = true
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-TESTING-route-table.id
# }
# resource "aws_ec2_transit_gateway_route" "tgw-TESTING6-route" {
#   destination_cidr_block         = "10.126.0.0/16"
#   blackhole                      = true
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-TESTING-route-table.id
# }
# resource "aws_ec2_transit_gateway_route" "tgw-TESTING5-route" {
#   destination_cidr_block         = "192.168.0.0/16"
#   blackhole                      = true
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-TESTING-route-table.id
# }
# resource "aws_ec2_transit_gateway_route" "tgw-TESTING4-route" {
#   destination_cidr_block         = "10.200.32.0/19"
#   blackhole                      = true
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-TESTING-route-table.id
# }
# resource "aws_ec2_transit_gateway_route" "tgw-TESTING3-route" {
#   destination_cidr_block         = "172.30.0.0/16"
#   blackhole                      = true
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-TESTING-route-table.id
# }
resource "aws_ec2_transit_gateway_route" "tgw-TESTING2-route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-TESTING-route-table.id
}
resource "aws_ec2_transit_gateway_route" "tgw-TESTING1-route" {
  destination_cidr_block         = "10.120.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.network-vpc-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-TESTING-route-table.id
}
### creation of transit gateway association
# resource "aws_ec2_transit_gateway_route_table_association" "TESTING" {
#   transit_gateway_attachment_id  = var.tgw-attach-testing-id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-TESTING-route-table.id
# }
# resource "aws_ec2_transit_gateway_route_table_association" "EDGE" {
#   transit_gateway_attachment_id  = var.tgw-attach-edge-id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-Edge-route-table.id
# }