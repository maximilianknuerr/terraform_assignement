
resource "aws_security_group" "web_server" {
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami = var.aws_ami_id
  instance_type = "t3.micro"

  key_name = "maximilian"
  vpc_security_group_ids = [aws_security_group.web_server.id]

  user_data = <<-EOF
            #!/bin/bash
              echo "Hello, World" > index.html
              nohup ruby /home/ubuntu/app.rb ${var.server_port} ${var.redis_address}
              EOF
}

resource "aws_eip" "ip" {
  instance = aws_instance.web_server.id
}

output "aws_eip" {
    value = aws_eip.ip.public_ip
}

output "webserver_id" {
    value = aws_security_group.web_server.id
}