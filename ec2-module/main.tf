provider "aws" {
  region     = "us-east-1"
  profile = "Create profile"# create a profile by using key pairs to connect servers via SSH
}
 module "sg-module" {
    sg_name = "sg_ec2_${local.env}"
    source = "./sg-module"
   
 }
module "ec2-module-1" {
  ec2_name = "ec2instance1_${local.env}"
  
  sg_id = "${module.sg-module.sg-output}"
  subnet_id = "${module.sg-module.subnet_output}"
    
  source = "./ec2-module"
  
}
locals {
  env = "${terraform.workspace}"
}


