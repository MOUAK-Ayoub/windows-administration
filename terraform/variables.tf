
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
  default = "us-east-1"
}

variable "external-ip" {
  default = "0.0.0.0/0"
}

variable "master-instance-type" {
  default = "t3.medium"
}

variable "slave-instance-type" {
  default = "t3.small"
}
variable "instance-count" {
  type    = number
  default = 2
}

variable "domain-name" {
  type    = string
  default = "mathai.local"
}

variable "pwd" {
  type    = string
  default = "Test2024!"
}

variable "ad-user" {
  type = list(object({
    firstname  = string
    lastname   = string
    logon_name = string
    pwd        = string
  }))
  default = [{
    firstname  = "imane"
    lastname   = "azirar"
    logon_name = "iazirar"
    pwd        = "Test2024!"
    }, {
    firstname  = "ayoub"
    lastname   = "mouak"
    logon_name = "amouak"
    pwd        = "Test2024!"

  }]

}
