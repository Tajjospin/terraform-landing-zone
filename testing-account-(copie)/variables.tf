variable "profile-name" {
    description = "local aws profile name"
    type = string
    default = "cno-sso"
}

variable "aws-region" {
    description = "define region to deploy"
    type = string
    default = "eu-west-1"
  
}
variable "nom-cluster" {
    description = "le nom du cluster à créer"
    type = string
    default = "testing-cluster"
}
variable "node-grp-name" {
    description = "node group name of testing cluster"
    type = string
    default = "testingNodeGroup"
}
variable "flow-log-bucket" {
    description = "bucket of all flow log in Log Archive account"
    type = string
    default = "arn:aws:s3:::jospin-bucket-de-log"
  
}

variable "vpc-cidr" {
    description = "IP address range of VPC"
    type = string
    default = "10.130.0.0/16"
}

variable "vpc-name" {
    description = "name of VPC"
    type = string
    default = "hub-testing "
  
}

variable "sub-priv-1-cidr" {
    description = "IP address range of private subnet of availabilty zone a"
    type = string
    default = "10.130.2.0/24"
}

variable "sub-priv-2-cidr" {
    description = "IP address range of private subnet of availabilty zone b"
    type = string
    default = "10.130.4.0/24"
}

variable "sub-priv-3-cidr" {
    description = "IP address range of private subnet of availabilty zone c"
    type = string
    default = "10.130.6.0/24"
}

variable "transit-network-id" {
    description = "ID of transit gateway of network account"
    type = string
    default = "tgw-0523df11fca0616fc"
}

variable "subnet_ids" {
    description = "l'ID de deux sous réseaux privés"
    type = list(string)
    default = []
  
}

variable "type-ec2" {
    description = "type des noeuds EC2 du cluster"
    type = string
    default = "t2.micro"
}

variable "node_capacity_type" {
    description = "détermine le type de réservation des noeud (ON_DEMAND ou SPOT)"
    type = string
    default = "SPOT"
}
variable "espace-disk" {
    description = "espace mémoire des disques ssd à alouer aux noueds du cluster"
    type = number
    default = 30
}

variable "node_max" {
    description = "contient le nombre maximal des noeuds du cluster"
    type = number
    default = 3
}

variable "node_desire" {
    description = "contient le nombre de noeuds demandés à régime normale"
    type = number
    default = 3 
}

variable "node_min" {
    description = "contient le nombre de noeuds minimale du cluster"
    type = number
    default = 3
}
