resource "aws_instance" "ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  private_ip                  = var.private_ip
  security_groups             = var.security_group
  user_data                   = var.user_data

  tags = merge(
    {
      "Name" = format("%s", var.name_instance)
    },
    var.tags
  )
}

resource "aws_eip" "ec2-ip" {
  instance = aws_instance.ec2.id
  vpc      = true
}
