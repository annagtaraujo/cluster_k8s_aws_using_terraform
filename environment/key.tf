module "ingress-keypair" {
  source = "../modules/key"

  key_name   = var.key_name

  tags = {
      Name = format("%s-publick-key", var.infra_name)
  }
}
