
variable "name" {

    type = string
    description = "Nome do Bucket"
}

variable "aws-region" {

    type = string
    description = ""
    default = "us-east-1"
}

variable "acl" {

    type = string
    description = ""
    default = "private"
}

variable "policy" {

    type = string
    description = ""
    default = null
}

variable "tags" {

    type = map(string)
    description = ""
    default = {}
}

variable "website" {

    description = "Mapeia as configurações do website"
    type = map(string)
    default = {}  
}

variable "key_prefix" {
  type    = string
  default = ""
}

variable "files" {
  type    = string
  default = ""
}
