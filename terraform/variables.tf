
variable "profile" {
  type    = string
  default = "default"
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}


variable "region" {
  type    = string
  default = "us-east-1"
}

variable "external-ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance-type" {
  type    = string
  default = "t3.medium"
}

variable "instance-count" {
  type    = number
  default = "3"
}

