provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

resource "aws_instance" "docker_server" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = "docker-server"
  subnet_id              = aws_subnet.main_subnet.id    
  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]
  user_data = file("./install-docker.sh") # Ensure the install.sh script is in the same directory as this Terraform file
  tags = {
    Name = "docker-server"
  }
}
  