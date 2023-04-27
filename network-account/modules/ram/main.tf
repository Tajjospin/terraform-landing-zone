
# creation of RAM 
resource "aws_ram_resource_share" "ram-1" {
  name                      = "ram-tgw-hub-network"
  allow_external_principals = false

  tags = {
    Environment = "Production"
  }
}

# associate the transit gateway ressource with the share
resource "aws_ram_resource_association" "transit-ram" {
  count = length(var.LIST_ARN)
  resource_arn       = var.LIST_ARN[count.index]
  resource_share_arn = aws_ram_resource_share.ram-1.arn
}

# associate the differents accounts
## testing account
resource "aws_ram_principal_association" "testing" {
  principal          = var.testing-account-id
  resource_share_arn = aws_ram_resource_share.ram-1.arn
}
