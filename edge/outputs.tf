output "tgw-attach-id-1" {
  description = "ID of the transit gateway attachment of MU PROD VPC"
  value       = module.mu-prod.tgw-attach-id-1
}
output "new-route-table" {
  description = "ID of the new routing table on MU PROD VPC"
  value       = module.mu-prod.new-route-table

}
output "mu-prod-subnet-attach" {
  description = "ID of new subnets attachment on MU PROD VPC"
  value       = module.mu-prod.subnet-attach
}