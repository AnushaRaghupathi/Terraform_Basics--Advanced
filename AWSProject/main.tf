provider "aws" {
    profile = "Create profile"# create a profile by using key pairs to connect servers via SSH
    region = "us-east-2"
  
}

module "network_module" {
    source = "./network_module"
  
}

module "loadbalancer_module" {
  source = "./loadbalancer_module"
  publicSg = "${module.network_module.publicSg}"
}

module "autoscaling_module" {
  source = "./autoscaling_module"
  privateSg = "${module.network_module.privateSg}"
  tg_arn  ="${module.loadbalancer_module.tg_arn}"
  
}