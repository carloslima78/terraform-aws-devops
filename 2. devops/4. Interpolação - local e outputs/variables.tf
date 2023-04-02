// Ambiente (Dev, Prod)
variable "environment" {

  type        = string
  description = ""
  default     = "Dev"
}

// Região
variable "aws-region" {

  type        = string
  description = ""
  default     = "us-east-1"
}


