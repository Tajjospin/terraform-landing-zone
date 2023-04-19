output "transit-ram-arn" {
    description = "the ARN of RAM that shares the transit gateway"
    value = aws_ram_resource_share.ram-1.arn
}
output "transit-ram-name" {
    description = "the name of RAM that shares the transit gateway"
    value = aws_ram_resource_share.ram-1.name
}