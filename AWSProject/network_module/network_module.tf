

module "shared-module" {
  source = "../shared_module"
  
}

resource "aws_security_group" "publicSg" {
  name        = "publicsg_name_${module.shared-module.ec2_suffix}"
  description = "puclic for ELB ${module.shared-module.ec2_suffix}"
  vpc_id      = "${module.shared-module.vpcid}"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

}

output "publicSg" {
    value = "${aws_security_group.publicSg.id}"
  
}

resource "aws_security_group" "privateSg" {
  name        = "privatesg_name_${module.shared-module.ec2_suffix}"
  description = "private for ELB ${module.shared-module.ec2_suffix}"
  vpc_id      = "${module.shared-module.vpcid}"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.publicSg.id]
   
  }

  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

}

output "privateSg" {
    value = "${aws_security_group.privateSg.id}"
  
}