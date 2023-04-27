# variable "transit-arn" {
#     description = "the ARN of transit gateway that we want to share"
#     type = string
  
# }
variable "testing-account-id" {
    description = "the ID of aws testing account that we want to associate"
    type = string
}
variable "LIST_ARN" {
  description = "list of all arn "
  type = list(string)

}