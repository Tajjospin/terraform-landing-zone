variable "node-grp-name" {
    description = "node group name of testing cluster"
    type = string
    default = ""
}

variable "subnet_ids" {
    description = "l'ID de deux sous réseaux privés"
    type = list(string)
    default = []
  
}

variable "cluster_name" {
    description = "le nom du cluster créé"
    type = string
    default = ""
  
}

variable "TYPE_EC2" {
    description = "type des noeuds EC2 du cluster"
    type = string
    default = "t3.medium"
}

variable "node_capacity_type" {
    description = "détermine le typt de réservation des noeud (ON_DEMAND ou SPOT)"
    type = string
    default = "SPOT"
}
variable "ESPACE_DISK" {
    description = "espace mémoire des disques ssd à alouer aux noueds du cluster"
    type = number
    default = 30
}

variable "node_max" {
    description = "contient le nombre maximal des noeuds du cluster"
    type = number
    default = 5
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