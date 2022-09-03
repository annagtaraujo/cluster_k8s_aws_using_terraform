#Instância master

module "k8s-master"{
  source = "../modules/ec2"

  name_instance = "k8s-teste-master"

  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = module.ingress-keypair.keypair_name
  private_ip                  = var.ip_master
  security_group              = [aws_security_group.k8s_sg.id]

  user_data = file("../scripts/script-k8s-master-inst.sh")

  depends_on = [
    aws_security_group.k8s_sg
  ]
}
##############################################################################

#Instâncias worker

module "k8s-worker"{
  source = "../modules/ec2"

  for_each = var.ip_worker
  name_instance = format("k8s-teste-%s",each.key)
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = module.ingress-keypair.keypair_name
  private_ip                  = each.value
  security_group              = [aws_security_group.k8s_sg.id]

  user_data = file("../scripts/script-k8s-worker-inst.sh")

  depends_on = [
    aws_security_group.k8s_sg
  ]
}
############################################################################

#Security Group

resource "aws_security_group" "k8s_sg" {
  name        = "k8s-teste-default-sg"
  description = "Allow all traffic"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-teste-default-sg"
  }
}
