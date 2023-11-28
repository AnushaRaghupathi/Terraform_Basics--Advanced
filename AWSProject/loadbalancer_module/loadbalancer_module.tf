

module "shared-module" {
    source = "../shared_module"
  
}

variable "publicSg" {
  
}


resource "aws_lb" "sampleapp_alb" {
  name               = "sampleapp-alb-${module.shared-module.ec2_suffix}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.publicSg}"]
  subnets            = ["${module.shared-module.publicsubnet}", "${module.shared-module.publicsubnet2}"]

  enable_deletion_protection = false 

  
  tags = {
    Environment = "${module.shared-module.ec2_suffix}"
  }
}

resource "aws_lb_target_group" "sampleapp-http-tg" {
  name     = "sampleapp-http-tg-${module.shared-module.ec2_suffix}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${module.shared-module.vpcid}"

}

output "tg_arn" {
  value = "${aws_lb_target_group.sampleapp-http-tg.arn}"
  
}
resource "aws_lb_listener" "http_listner_80" {
  load_balancer_arn = "${aws_lb.sampleapp_alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.sampleapp-http-tg.arn}"
  }
}