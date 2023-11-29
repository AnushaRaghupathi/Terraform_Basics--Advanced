provider "aws" {
  region     = "us-east-1"
  profile = "Create profile"# create a profile by using key pairs to connect servers via SSH
}
variable "vpc1" {
    type = string
    default = "vpc-00577b0a04a431951"
  
}

resource "aws_security_group" "awsSg-24-11" {
  name        = "awsSg-24-11"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${var.vpc1}"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "${var.vpc1}"
  cidr_block = "172.31.0.0/16"

  
}

variable "amiid" {
  type = string
  default = "ami-0fa1ca9559f1892ec"
  
}

resource "aws_instance" "web" {

  ami           = "${var.amiid}"
  instance_type = "t2.micro"
  key_name = "terraform"
  vpc_security_group_ids = [aws_security_group.awsSg-24-11.id]
  subnet_id = aws_subnet.main.id

  tags = {
    Name = "Helloorld"
  }
}