resource "aws_instance" "ubuntu_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data              = file("./scripts/install_sonarqube.sh")
  key_name               = aws_key_pair.generated_key.key_name
  tags = {
    Name = var.tags
  }
}


