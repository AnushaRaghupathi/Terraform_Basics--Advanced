provider "aws" {
    region = "us-east-1"
    profile = "rojamma-terraformlearning"
  
}

variable "vpcid" {
  type = string
  default = "vpc-00577b0a04a431951"
}

resource "aws_security_group" "tf_ec2_sc" {
  name        = "tf_ec2_sc"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${var.vpcid}"

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

  
}


 resource "aws_subnet" "example_subnet" {
  vpc_id                  = "${var.vpcid}"  # Specify your default VPC ID
  cidr_block              = "172.31.0.0/16"  # Specify a CIDR block for your subnet
 # availability_zone       = "ap-south-1a"  # Specify an availability zone in your region
}

variable "amiid" {
  type = string
    default = "ami-02aead0a55359d6ec"
  
}

resource "aws_instance" "tf_ec2" {
  ami           = var.amiid
  instance_type = "t2.micro"
  key_name = "terraform"
  vpc_security_group_ids  = [aws_security_group.tf_ec2_sc.id]
  subnet_id = aws_subnet.example_subnet.id

  tags = {
    Name = "HelloWorld"
  }
}