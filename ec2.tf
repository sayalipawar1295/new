resource "aws_instance" "server" {
  ami                    = "ami-045443a70fafb8bbc"
  instance_type          = "t3.micro"
  key_name               = "oncdec-b36"
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = <<EOF
    #!/bin/bash
    sudo -i
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo "hello terrafom" > /var/www/html/index.html
    EOF

  tags = {
    name = "webserver"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = "vpc-0e63dbcf6cd169d82"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
