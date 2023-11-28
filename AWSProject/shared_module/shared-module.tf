
output "vpcid" {
    value = "${local.vpcid}"
  
}

output "publicsubnet" {
    value = "${local.publicsubnet}"
  
}

output "publicsubnet2" {
    value = "${local.publicsubnet2}"
  
}

output "privatesubnet" {
    value = "${local.privatesubnet}"
  
}

output "ec2_suffix" {
    value = "${local.env}"
  
}




locals {
  env = "${terraform.workspace}"

  vpcid_env = {
    default = "vpc-0b16e5467039494ce"
    staging = "vpc-0b16e5467039494ce"
    production = "vpc-0b16e5467039494ce"
  }

  vpcid = "${lookup(local.vpcid_env, local.env)}"

  publicsubnetid_env = {
    default = "subnet-09abd181736a553b1"
    staging = "subnet-09abd181736a553b1"
    production = "subnet-09abd181736a553b1"
  }

  publicsubnet = "${lookup(local.publicsubnetid_env, local.env)}"

   publicsubnetid2_env = {
    default = "subnet-0f41ccdc27ed19181"
    staging = "subnet-0f41ccdc27ed19181"
    production = "subnet-0f41ccdc27ed19181"
  }

  publicsubnet2 = "${lookup(local.publicsubnetid2_env, local.env)}"

  privatesubnet_env = {
    default = "subnet-0d5c031d62951fca3"
    staging = "subnet-0d5c031d62951fca3"
    production = "subnet-0d5c031d62951fca3"
  }

  privatesubnet = "${lookup(local.privatesubnet_env, local.env)}"


  
}