output "dns-associate-id" {
  value = module.HZ_1.dn-associate-id
}
output "hosted-zone-id" {
  value = module.HZ_1.hosted-zone-id
}
output "vpc-associate-dns-id" {
  value = module.NET_ASS_HZ_1.vpc-associate-dns-id
}
output "list-record" {
  value = module.HZ_1.record
}