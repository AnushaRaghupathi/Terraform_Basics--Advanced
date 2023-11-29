provider "aws" {
  region     = "us-east-2"
  profile = "Create profile"# create a profile by using key pairs to connect servers via SSH
}
 module "sg-module" {
    #sg_name = "sg_ec2_${local.env}"
    source = "./sg-module"
   
 }
module "ec2-module" {
   # ec2_name = "${module.ec2-module.ec2_name}"
  
  sg_id = "${module.sg-module.sg-output}"
 # subnet_id = "${module.sg-module.subnet_output}"*/
    
  source = "./ec2-module"
  
}


/*locals {
  env = "${terraform.workspace}"

  amiid_env = {
    default = "amiid_default"
    staging = "amiid_staging"
    production = "amiid_prodection"
  }

  amiid = "${lookup(local.amiid_env, local.env)}"
  
  
}

output "envspecificoutput_var" {
  value = "${local.amiid}"
  
}*/


