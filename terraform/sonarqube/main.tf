variable "pem_private_key_path" {
  description = "Raw private key content from GitHub Actions secret"
  type        = string
  sensitive   = true
}

resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube-sg"
  description = "Allow SonarQube and SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "sonarqube_runner" {
  ami                    = "ami-02d26659fd82cf299" 
  instance_type          = "t2.medium"
  key_name               = "sonarqube" 
  vpc_security_group_ids = [aws_security_group.sonarqube_sg.id]

  root_block_device {
    volume_size = 15
  }

  tags = {
    Name = "SonarQube-Runner"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y docker.io",
      "sudo sysctl -w vm.max_map_count=524288",
      "sudo sysctl -w fs.file-max=131072",
      "ulimit -n 131072",
      "ulimit -u 8192",
      "sudo docker run -d --name sonarqube -p 9000:9000 \\",
      "  -v sonarqube_data:/opt/sonarqube/data \\",
      "  -v sonarqube_logs:/opt/sonarqube/logs \\",
      "  -v sonarqube_extensions:/opt/sonarqube/extensions \\",
      "  sonarqube:community"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.pem_private_key_path
      host        = self.public_ip
    }
  }
}

output "sonarqube_ip" {
  value = aws_instance.sonarqube_runner.public_ip
}
