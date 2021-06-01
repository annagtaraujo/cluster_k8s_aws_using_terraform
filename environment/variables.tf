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

variable "public_key"{
  type = string
  description = "Public key de acesso às instâncias públicas"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpuAcCDGl/ONwyusp4q34RVPA5py/1Acj6zPHQcMnPJsbAajg5qpEunxncmPio35Qf1Q5HcVxpK2IpSRVJUH3C8n8EUWPvOZIBApfTcGumUO1UhTQr7lv/3Jthpn3jYivLYk8RsRj55noW/HbWVesEnitWQmAIhi169t/yAknPH6cyXImJe6o6WfbMU/6h8iZ7XLYbt8AmcXRK0oUgY9m9TFvQHVW2SOdhNzI+LI+YeBovNV+esDDMb7s7fpo+dFolubslyhbOlt09W7iLIDvUh+/1ooYtt5NOGDlQlbgEQqpVnd5xuL/8mU144VGvrJT1NbRLKf4VRHa5jfe4GTh7 annagtaraujo@BRRIOWN021449"
}

variable "key_name"{
  type = string
  description = "Nome da KeyPair"
  default = "anna-lab"
}