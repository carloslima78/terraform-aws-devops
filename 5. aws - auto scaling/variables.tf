variable "aws_region" {
  type        = string
  description = ""
  default     = "eu-central-1"
}

variable "aws_account_id" {
  type        = number
  description = ""
  default     = 303315406913
}

variable "service_name" {
  type        = string
  description = ""
  default     = "autoscaling-app"
}

variable "instance_type" {
  type        = string
  description = ""
  default     = "t3.micro"
}

variable "instance_key_name" {
  type        = string
  description = ""
  default     = "carlos_kp"
}