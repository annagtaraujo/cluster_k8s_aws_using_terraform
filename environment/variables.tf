variable "aws_region" {
  description = "aws region"
  default = "us-west-2"
}
variable "infra_name" {
  type = string
  description = "infra name"
  default = "banking-network"
}

variable "ip_master"{
  type = string
  description = "IPs privados do master na VPC default"
  default = "172.31.1.10"
}

variable "ip_worker"{
  type = map(string)
  description = "IPs privados dos workers na VPC default"
  default = {"worker-01":"172.31.1.11","worker-02":"172.31.1.12"}
}

variable "ami"{
  type = string
  description = "AMI Ubuntu 20.04 em us-west-2"
  default = "ami-0ca5c3bd5a268e7db"
}

variable "instance_type"{
  type = string
  description = "Tipo das instâncias"
  default = "t2.medium"
}

variable "key_name"{
  type = string
  description = "Nome da KeyPair"
  default = "anna-lab"
}
