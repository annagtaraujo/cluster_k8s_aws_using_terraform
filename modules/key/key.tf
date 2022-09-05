#Key Pair

resource "aws_key_pair" "keypair" {

  key_name   = var.key_name
  public_key = tls_private_key.private_key_pem.public_key_openssh

  tags = {
      Name = format("%s-public-key", var.infra_name)
  }
}

resource "tls_private_key" "private_key_pem" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "keypair-file" {
    content  = tls_private_key.private_key_pem.private_key_pem
    filename = format("/home/annagtaraujo/.ssh/%s.pem", var.key_name)
}
