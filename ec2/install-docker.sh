  #!/bin/bash 
  sudo yum update -y
    echo "Updating packages" >> /home/ec2-user/userdata.log
  sudo amazon-linux-extras enable docker
    echo "Enabling Docker extras" >> /home/ec2-user/userdata.log
 sudo yum install docker -y
    echo "Installing Docker" >> /home/ec2-user/userdata.log
  sudo systemctl start docker
    echo "Starting Docker service" >> /home/ec2-user/userdata.log
  sudo systemctl enable docker
    echo "Enabling Docker service to start on boot" >> /home/ec2-user/userdata.log
  sudo usermod -aG docker ec2-user
    echo "Adding ec2-user to docker group" >> /home/ec2-user/userdata.log
  echo "Docker installed" >> /home/ec2-user/userdata.log
