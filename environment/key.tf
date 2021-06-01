module "ingress-keypair" {
  source = "../modules/key"

  key_name   = var.key_name
  public_key = var.public_key

  tags = {
      Name = format("%s-publick-key", var.infra_name)
  }
}