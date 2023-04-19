## import certificate

resource "aws_acm_certificate" "vpn_client_root" {
  private_key = file("cert/private_key.pem")
  certificate_body = file("cert/certificate.txt")
  certificate_chain = file("cert/certificate_chain.txt")

  tags = {
    "Name" = "vpn-client-network"
  }
}


resource "aws_ec2_client_vpn_endpoint" "vpn-client" {
  description            = "terraform-clientvpn-vpn-client"
  server_certificate_arn = aws_acm_certificate.vpn_client_root.arn
  client_cidr_block      = "10.80.0.0/22"

authentication_options {
  #   type                       = "certificate-authentication"
  #   root_certificate_chain_arn = aws_acm_certificate.vpn_client_root.arn
  type = "federated-authentication"
  saml_provider_arn = var.saml-provide-arn
  self_service_saml_provider_arn = var.self-samlprovide-arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.lg.name
  }
}

resource "aws_cloudwatch_log_group" "lg" {
  name              = "client-vpn-endpoint-${var.domain}"
  retention_in_days = "30"

  tags = {
    Name        = var.domain
  }
}

# VPN security group
resource "aws_security_group" "vpn_access" {
  vpc_id = var.vpc-id
  name = "vpn-client-sg"

  ingress {
    from_port = 443
    protocol = "UDP"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "Incoming VPN connection"
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## association the vpn with the subnets and security group

resource "aws_ec2_client_vpn_network_association" "vpn-ass" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn-client.id
  subnet_id              = var.subnet-id
  security_groups        = [aws_security_group.vpn_access.id]

  lifecycle {
    ignore_changes = [subnet_id]
  }
}
## create a vpn route
resource "aws_ec2_client_vpn_route" "vpn-route" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn-client.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.vpn-ass.subnet_id
}

resource "aws_ec2_client_vpn_authorization_rule" "vpn_auth_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn-client.id
  target_network_cidr = var.vpc-cidr-block
  authorize_all_groups = true
}