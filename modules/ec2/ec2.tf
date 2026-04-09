resource "aws_instance" "vm" {
  ami                    = var.ami_id
  instance_type          = var.ins_type
  key_name               = var.key_pair
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group]
  tags = {
    Name = "tf-server"
  }
}
