resource "aws_vpc" "vnet" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "pub" {
  vpc_id                  = aws_vpc.vnet.id
  cidr_block              = var.subnet_cidr_block[0]
  availability_zone       = var.az[0]
  map_public_ip_on_launch = var.assign_pub_ip
  tags = {
    Name = "tf-subnet-pub"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vnet.id
  tags = {
    Name = "tf-igw"
  }
}

resource "aws_route_table" "rt-1" {
  vpc_id = aws_vpc.vnet.id
  tags = {
    Name = "rt-public"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table_association" "rta-1" {
  subnet_id      = aws_subnet.pub.id
  route_table_id = aws_route_table.rt-1.id
}

# add private subnet

resource "aws_subnet" "pri" {
  vpc_id                  = aws_vpc.vnet.id
  cidr_block              = var.subnet_cidr_block[1]
  availability_zone       = var.az[1]
  map_public_ip_on_launch = var.no_public_ip
  tags = {
    Name = "Private-subnet"
  }
}

resource "aws_eip" "fixed" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.fixed.id
  subnet_id     = aws_subnet.pub.id
  tags = {
    Name = "nat-gw-vpc-tf"
  }
}

resource "aws_route_table" "rt-2" {
  vpc_id = aws_vpc.vnet.id
  tags = {
    Name = "rt-private"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}


resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.pri.id
  route_table_id = aws_route_table.rt-2.id
}
# create security group
resource "aws_security_group" "firewall" {
  vpc_id = aws_vpc.vnet.id
  name   = "tf-vpc-sg"

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

resource "aws_instance" "vm" {
  ami                    = var.ami_id
  instance_type          = var.ins_type
  key_name               = var.key_pair
  user_data              = <<-EOF
                #!/bin/bash
                sudo -i
                yum update -y
                yum install httpd -y
                systemctl start httpd
                systemctl enable httpd
                echo "Hello World from Terraform" > /var/www/html/index.html
                EOF
  subnet_id              = aws_subnet.pub.id
  vpc_security_group_ids = [aws_security_group.firewall.id]
  tags = {
    Name = "tf-server"
  }
}
