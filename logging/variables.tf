variable "profile-name" {
    description = "local aws profile name"
    type = string
    default = "cno-sso"
}
# variable "flow-log-bucket" {
#     description = "bucket of all flow log in Log Archive account"
#     type = string
#     default = "arn:aws:s3:::terraform-logs-tests"
  
# }

variable "aws-region" {
    description = "define region to deploy"
    type = string
    default = "eu-west-1"
  
}