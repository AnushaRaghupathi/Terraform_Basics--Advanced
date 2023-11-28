provider "aws" {
    profile = "rojamma-terraformlearning"
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