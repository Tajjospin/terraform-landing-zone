output "vpc-id" {
    value = aws_vpc.main.id
}

output "vpc-cidr-block" {
    description = "ip address range of VPC"
    value = aws_vpc.main.cidr_block 
}
output "priv-subnet-1" {
    description = "ip address range of private subnet 1 AZ-a"
    value = aws_subnet.sub-priv-1.cidr_block
}
output "priv-subnet-1-id" {
    description = "ID of private subnet 1 AZ-a"
    value = aws_subnet.sub-priv-1.id
}
output "priv-subnet-2" {
    description = "ip address range of private subnet 1 AZ-b"
    value = aws_subnet.sub-priv-2.cidr_block
}
output "priv-subnet-2-id" {
    description = "ID of private subnet 1 AZ-b"
    value = aws_subnet.sub-priv-2.id
}
output "priv-subnet-3" {
    description = "ip address range of private subnet 1 AZ-c"
    value = aws_subnet.sub-priv-3.cidr_block
}
output "priv-subnet-3-id" {
    description = "ID of private subnet 3 AZ-c"
    value = aws_subnet.sub-priv-3.id
}
output "pub-subnet-1" {
    description = "ip address range of private subnet 1 AZ-a"
    value = aws_subnet.sub-pub-1.cidr_block
}
output "pub-subnet-1-id" {
    description = "ID of public subnet 1 AZ-a"
    value = aws_subnet.sub-pub-1.id 
}
output "pub-subnet-1-arn" {
    description = "ARN of public subnet 1 AZ-a"
    value = aws_subnet.sub-pub-1.arn
}
output "pub-subnet-2" {
    description = "ip address range of public subnet 2 AZ-b"
    value = aws_subnet.sub-pub-2.cidr_block
}
output "pub-subnet-2-id" {
    description = "ID of public subnet 2 AZ-b"
    value = aws_subnet.sub-pub-2.id
}
output "pub-subnet-2-arn" {
    description = "ARN of public subnet 2 AZ-b"
    value = aws_subnet.sub-pub-2.arn
}
output "pub-subnet-3" {
    description = "ip address range of public subnet 3 AZ-c"
    value = aws_subnet.sub-pub-3.cidr_block
}
output "pub-subnet-3-id" {
    description = "ID of public subnet 1 AZ-c"
    value = aws_subnet.sub-pub-3.id
}
output "pub-subnet-3-arn" {
    description = "ARN of public subnet 3 AZ-c"
    value = aws_subnet.sub-pub-3.arn
}
# output "flow-log-network-vpc" {
#     description = "the flow logs of transit gateway"
#     value = aws_flow_log.vpc-flow-logs.id
  
# }