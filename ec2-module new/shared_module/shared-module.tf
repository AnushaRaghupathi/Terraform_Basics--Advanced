locals {
  env = "${terraform.workspace}"

  ec2_suffix_env = {
    
    default = "default"
    staging = "staging"
    production = "production"
  }

  ec2_suffix = "${lookup(local.ec2_suffix_env, local.env)}"
  
  
}

output "ec2_suffix" {
  value = "${local.ec2_suffix}"
 
  
}