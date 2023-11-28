module "shared-module" {
    source = "../shared_module"
  
}

variable "privateSg" {}
variable "tg_arn" {}

locals {
  env ="${terraform.workspace}"

  amiid_env = {
    default = "ami-06d4b7182ac3480fa"
    staging = "ami-06d4b7182ac3480fa"
    production = "ami-06d4b7182ac3480fa"
  }

  amiid = "${lookup(local.amiid_env, local.env)}"


instancetype_env = {
    default = "t2.micro"
    staging = "t2.micro"
    production = "t2.medium"
  }

  instancetype = "${lookup(local.instancetype_env, local.env)}"

keypairname_env = {
    default = "awsproject_tf_staging"
    staging = "awsproject_tf_staging"
    production = "awsproject_tf_production"
  }

  keypairname = "${lookup(local.keypairname_env, local.env)}"


asgmin_env = {
    default = "1"
    staging = "1"
    production = "2"
  }

  asgmin = "${lookup(local.asgmin_env, local.env)}"


asgmax_env = {
    default = "2"
    staging = "2"
    production = "4"
  }

  asgmax = "${lookup(local.asgmax_env, local.env)}"

asgdesired_env = {
    default = "1"
    staging = "1"
    production = "2"
  }

  asgdesired = "${lookup(local.asgdesired_env, local.env)}"
}




resource "aws_launch_configuration" "sampleapp_lc" {
  name          = "sampleapp_lc_${local.env}"
  image_id      = "${local.amiid}"
  instance_type = "${local.instancetype}"
  key_name = "${local.keypairname}"
  user_data = "${file("userdata/userdata.txt")}"
  security_groups = ["${var.privateSg}"]

}

resource "aws_autoscaling_group" "sampleapp_asg" {
    name = "sampleapp_sg_${module.shared-module.ec2_suffix}"
    max_size = "${local.asgmax}"
    min_size = "${local.asgmin}"
    desired_capacity = "${local.asgdesired}"
    launch_configuration = "${aws_launch_configuration.sampleapp_lc.name}"
    vpc_zone_identifier = ["${module.shared-module.publicsubnet}"]
    target_group_arns = ["${var.tg_arn}"]


    tag { 
        
            key                 =   "Name"
            value               =   "SampleApp_${module.shared-module.ec2_suffix}"
            propagate_at_launch =   true   
        }

        tag {
            key     = "Environment"
            value   = "${module.shared-module.ec2_suffix}"
            propagate_at_launch =   true 
        }
    
    
}

