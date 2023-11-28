variable "amiid" {
  type = string
  default = "ami-0fa1ca9559f1892ec"
  
}
variable "sg_id" {}
  
variable "ec2_name" {}

variable "subnet_id" {}

resource "aws_instance" "web" {

  ami           = "${var.amiid}"
  instance_type = "t2.micro"
  key_name = "terraform"
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnet_id

  tags = {
    name = "${var.ec2_name}"
  }
}




 


  
