variable "vpc1" {
    type = string
    default = "vpc-00577b0a04a431951"
  
}

  
variable "sg_name" {
  
}

resource "aws_security_group" "awsSg-25-11" {
  name        = "${var.sg_name}"
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

  

}

resource "aws_subnet" "main" {
  vpc_id     = "${var.vpc1}"
  cidr_block = "172.31.0.0/16"
   map_public_ip_on_launch = true

  
}


 output "sg-output" {
    value = "${aws_security_group.awsSg-25-11.id}"
   
 }

 output "subnet_output" {
   value = "${aws_subnet.main.id}"
 }