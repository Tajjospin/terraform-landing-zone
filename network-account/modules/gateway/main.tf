# creation of Internet Gateway (IGW)
resource "aws_internet_gateway" "igw" {
  vpc_id = var.network-vpc-id

  tags = {
    "Name" = var.network-igw-name
  }
}

# creation of public routing table
resource "aws_route_table" "public-route" {
  vpc_id = var.network-vpc-id
  
  route {
    cidr_block = var.testing-vpc-cidr-block
    transit_gateway_id = var.transit-gateway-id
  }
  route {
    cidr_block = var.shared-vpc-cidr-block
    transit_gateway_id = var.transit-gateway-id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-table"
  }
}

# Association of the routing table (RT) created above with the pubics subnetwork

# Association of the RT to the public subnetwork of the AZ-A
resource "aws_route_table_association" "public-association-1a" {
  subnet_id = var.sub-pub-1-id
  route_table_id = aws_route_table.public-route.id
}
# Association of the RT to the public subnetwork of the AZ-B
resource "aws_route_table_association" "public-association-1b" {
  subnet_id = var.sub-pub-2-id
  route_table_id = aws_route_table.public-route.id
}
# Association of the RT to the public subnetwork of the AZ-C
resource "aws_route_table_association" "public-association-1c" {
  subnet_id = var.sub-pub-3-id
  route_table_id = aws_route_table.public-route.id
}

# creation of an Elastic IP Address (EIP) in the VPC
resource "aws_eip" "nat-eip-1" {
  vpc = true

  tags = {
    "Name" = "NAT-1-eip"
  }
  }

# NAT gateway creation with a elastic IP for the AZ-a
  resource "aws_nat_gateway" "nat-1" {
    allocation_id = aws_eip.nat-eip-1.id
    subnet_id = var.sub-pub-1-id

    tags = {
      "Name" = "NAT-1"
    }
    depends_on = [
      aws_internet_gateway.igw
    ]
  }

# creation of private routing table for AZ-a
resource "aws_route_table" "private-route-1" {
  vpc_id = var.network-vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-1.id
  }
  route {
    cidr_block = var.testing-vpc-cidr-block
    transit_gateway_id = var.transit-gateway-id
  }

  tags = {
    Name = "Tab-sub-priv-1"
  }
}
# Association of the RT to the private subnetwork of the AZ-A
resource "aws_route_table_association" "private-association-1a" {
  subnet_id = var.sub-priv-1-id
  route_table_id = aws_route_table.private-route-1.id
}

resource "aws_eip" "nat-eip-2" {
  vpc = true

  tags = {
    "Name" = "NAT-2-eip"
  }
  }

# NAT gateway creation with a elastic IP for the AZ-b
  resource "aws_nat_gateway" "nat-2" {
    allocation_id = aws_eip.nat-eip-2.id
    subnet_id = var.sub-pub-2-id

    tags = {
      "Name" = "NAT-2"
    }
    depends_on = [
      aws_internet_gateway.igw
    ]
  }
# creation of private routing table for AZ-b
resource "aws_route_table" "private-route-2" {
  vpc_id = var.network-vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-2.id
  }
  route {
    cidr_block = var.testing-vpc-cidr-block
    transit_gateway_id = var.transit-gateway-id
  }

  tags = {
    Name = "Tab-sub-priv-2"
  }
}
# Association of the RT to the private subnetwork of the AZ-B
resource "aws_route_table_association" "private-association-1b" {
  subnet_id = var.sub-priv-2-id
  route_table_id = aws_route_table.private-route-2.id
}

resource "aws_eip" "nat-eip-3" {
  vpc = true

  tags = {
    "Name" = "NAT-3-eip"
  }
  }

# NAT gateway creation with a elastic IP for the AZ-c
  resource "aws_nat_gateway" "nat-3" {
    allocation_id = aws_eip.nat-eip-3.id
    subnet_id = var.sub-pub-3-id

    tags = {
      "Name" = "NAT-3"
    }
    depends_on = [
      aws_internet_gateway.igw
    ]
  }
  # creation of private routing table for AZ-c
resource "aws_route_table" "private-route-3" {
  vpc_id = var.network-vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-3.id
  }
  route {
    cidr_block = var.testing-vpc-cidr-block
    transit_gateway_id = var.transit-gateway-id
  }

  tags = {
    Name = "Tab-sub-priv-3"
  }
}
# Association of the RT to the private subnetwork of the AZ-C
resource "aws_route_table_association" "private-association-1c" {
  subnet_id = var.sub-priv-3-id
  route_table_id = aws_route_table.private-route-3.id
}
