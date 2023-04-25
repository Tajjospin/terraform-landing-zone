
variable "DNS_ZONE_ID" {
  description = "ID DNS hosted zone"
  type = string
}
variable "LIST_VPC_ID" {
  description = "list of all vpc "
  type = list(object({
    name     = string
    ID       = string
  }))

}