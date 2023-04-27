resource "aws_vpc" "main" {
  cidr_block       = var.vpc-cidr
  enable_network_address_usage_metrics = true
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = var.vpc-name
  }
}

# define the private subnets

resource "aws_subnet" "sub-priv-1" {
  vpc_id     = aws_vpc.main.id
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 0)
  cidr_block = var.sub-priv-1-cidr
  availability_zone = "${var.aws-region}a"
  tags = {
    Name = "Sub-Priv-1"
  }
}
resource "aws_subnet" "sub-priv-2" {
  vpc_id     = aws_vpc.main.id
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)
  cidr_block = var.sub-priv-2-cidr
  availability_zone = "${var.aws-region}b"

  tags = {
    Name = "Sub-Priv-2"
  }
}

resource "aws_subnet" "sub-priv-3" {
  vpc_id     = aws_vpc.main.id
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 4)
  cidr_block = var.sub-priv-3-cidr
  availability_zone = "${var.aws-region}c"

  tags = {
    Name = "Sub-Priv-3"
  }
}


# define the publics subnets

resource "aws_subnet" "sub-pub-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub-pub-1-cidr
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 6)
  availability_zone = "${var.aws-region}a"

  tags = {
    Name = "Sub-Pub-1"
  }
}
resource "aws_subnet" "sub-pub-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub-pub-2-cidr
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 8)
  availability_zone = "${var.aws-region}b"

  tags = {
    Name = "Sub-Pub-2"
  }
}

resource "aws_subnet" "sub-pub-3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub-pub-3-cidr
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 10)
  availability_zone = "${var.aws-region}c"

  tags = {
    Name = "Sub-Pub-3"
  }
}


## creation of vpc flow logs
# resource "aws_flow_log" "vpc-flow-logs" {
# # specify the ARN of logs bucket in Logs Archive account
#   # log_destination      = var.flow-log-bucket
#   # log_destination      = "arn:aws:s3:::jospin-bucket-de-log/network-vpcflowlogs/"
#   log_destination      = "arn:aws:s3:::jospin-bucket-de-log/network-vpc-flowlogs"
#   log_destination_type = "s3"
#   traffic_type         = "ALL"
#   vpc_id               = aws_vpc.main.id
#   destination_options {
#     file_format        = "parquet"
#     per_hour_partition = true
#   }
#   depends_on = [
#     aws_vpc.main
#   ]
  
#   tags = {
#     "Name" = "flow-log-hub-network"
#   }
# }
