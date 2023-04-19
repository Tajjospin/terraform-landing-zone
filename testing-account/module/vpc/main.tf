resource "aws_vpc" "main" {
  cidr_block       = var.vpc-cidr
  enable_network_address_usage_metrics = true
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = var.vpc-name
  }
}

# define the private subnets

resource "aws_subnet" "sub-priv-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub-priv-cidr[0]
  availability_zone = "${var.aws-region}a"
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 0)
  tags = {
    Name = "sub-priv-1"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/role/elb" = "1"
  }
}
resource "aws_subnet" "sub-priv-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub-priv-cidr[1]
  availability_zone = "${var.aws-region}b"
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)

  tags = {
    Name = "sub-priv-2"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "sub-priv-3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub-priv-cidr[2]
  availability_zone = "${var.aws-region}c"
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 4)

  tags = {
    Name = "sub-priv-3"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/role/elb" = "1"
  }
}
# creation of vpc flow logs
resource "aws_flow_log" "vpc-flow-logs" {
# specify the ARN of logs bucket in Logs Archive account
  log_destination      = "${var.flow-log-bucket}/testing-vpc-logs/"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id
  destination_options {
    file_format        = "parquet"
    per_hour_partition = true
    hive_compatible_partitions = true
  }
  depends_on = [
    aws_vpc.main
  ]
  
  tags = {
    "Name" = "flow-log-hub-testing"
  }
}

# create routing table to transit gateway
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = var.transit-network-id
  }
  route {
    ipv6_cidr_block        = "::/0"
    transit_gateway_id = var.transit-network-id
  }


  tags = {
    Name = "tab-sub-pub1"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "network-vpc-attach" {
  subnet_ids         = [ aws_subnet.sub-priv-2.id, aws_subnet.sub-priv-3.id, aws_subnet.sub-priv-1.id ]
  transit_gateway_id = var.transit-network-id
  vpc_id             = aws_vpc.main.id
  
  tags = {
    "Name" = "tgw-attach-hub-testing"
  }
}
# Liaison de la table de routage ci dessus au réseau privé de l'AZ-A
resource "aws_route_table_association" "association-private-subnet-1" {
  subnet_id = aws_subnet.sub-priv-1.id
  route_table_id = aws_route_table.public-route.id
}
# Liaison de la table de routage ci dessus au réseau privé de l'AZ-B
resource "aws_route_table_association" "association-private-subnet-2" {
  subnet_id = aws_subnet.sub-priv-2.id
  route_table_id = aws_route_table.public-route.id
}
# Liaison de la table de routage ci dessus au réseau privé de l'AZ-C
resource "aws_route_table_association" "association-private-subnet-3" {
  subnet_id = aws_subnet.sub-priv-3.id
  route_table_id = aws_route_table.public-route.id
}

################################### end points

# aws_vpc_endpoint.vpce-s3:
resource "aws_vpc_endpoint" "vpce-s3" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
      Version = "2008-10-17"
    }
  )
  private_dns_enabled = false
  route_table_ids = [
    aws_route_table.public-route.id
  ]
  security_group_ids = []
  service_name       = "com.amazonaws.eu-west-1.s3"
  subnet_ids         = []
  tags               = {
    "Name" = "vpc-end-point-S3"
  }
  vpc_endpoint_type  = "Gateway"
  vpc_id             = aws_vpc.main.id
  auto_accept = true

  timeouts {}
}
###################### enpoint ec2

resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-west-1.ec2"
  vpc_endpoint_type = "Interface"
  auto_accept = true
  subnet_ids = [aws_subnet.sub-priv-1.id, aws_subnet.sub-priv-2.id, aws_subnet.sub-priv-3.id]

  security_group_ids = [aws_security_group.sg.id]

  private_dns_enabled = true

  tags = {
    "Name" = "vpc-end-point-ec2"
  }
}

########################## endpoint cloudwatch

resource "aws_vpc_endpoint" "log" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-west-1.logs"
  vpc_endpoint_type = "Interface"
  auto_accept = true
  subnet_ids = [aws_subnet.sub-priv-1.id, aws_subnet.sub-priv-2.id, aws_subnet.sub-priv-3.id]

  security_group_ids = [aws_security_group.sg.id]

  private_dns_enabled = true

  tags = {
    "Name" = "vpc-end-point-logs"
  }
}


############################## endpoint sts

resource "aws_vpc_endpoint" "sts" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-west-1.sts"
  vpc_endpoint_type = "Interface"
  auto_accept = true
  subnet_ids = [aws_subnet.sub-priv-1.id, aws_subnet.sub-priv-2.id, aws_subnet.sub-priv-3.id]

  security_group_ids = [aws_security_group.sg.id]

  private_dns_enabled = true

  tags = {
    "Name" = "vpc-end-point-sts"
  }
}

########################## endpoint ecr-dkr

resource "aws_vpc_endpoint" "dkr" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-west-1.ecr.dkr"
  vpc_endpoint_type = "Interface"
  auto_accept = true
  subnet_ids = [aws_subnet.sub-priv-1.id, aws_subnet.sub-priv-2.id, aws_subnet.sub-priv-3.id]

  security_group_ids = [aws_security_group.sg.id]

  private_dns_enabled = true

  tags = {
    "Name" = "vpc-end-point-ecr-dkr"
  }
}


############################## endpoint ecr-api

resource "aws_vpc_endpoint" "api" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.eu-west-1.ecr.api"
  vpc_endpoint_type = "Interface"
  auto_accept = true
  subnet_ids = [aws_subnet.sub-priv-1.id, aws_subnet.sub-priv-2.id, aws_subnet.sub-priv-3.id]

  security_group_ids = [aws_security_group.sg.id]

  private_dns_enabled = true

  tags = {
    "Name" = "vpc-end-point-ecr-api"
  }
}



# création du groupe de sécurité
resource "aws_security_group" "sg" {
  name        = "allow_bastion"
  description = "Allow inbound traffic"
  vpc_id = aws_vpc.main.id
 


  ingress {
    description      = "ALL access"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  egress {
    description      = "ALL "
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}
