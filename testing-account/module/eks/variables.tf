
variable "nom-cluster" {
    description = "le nom du cluster à créer"
    type = string
    default = "testing-cluster"
}

variable "subnet" {
    description = "contient les sous réseaux configurées"
    type = list(string)
    default = []
}
variable "vpc-testing-id" {
  description = "ID of VPC shared"
  type = string
  
}