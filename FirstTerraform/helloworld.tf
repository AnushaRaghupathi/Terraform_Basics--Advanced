provider "aws" {
    region = "ap-south-1"
    profile = ""Create profile"# create a profile by using key pairs to connect servers via SSH
    #access_key = "*************"
    #secret_key = "*******************************"
    # Always use profile instead of providing access keys
    # by using profile- tracking is easy who worked on the last configuration
  
}

///// this is a string variable/////

variable "myfirststring" {
    type = string   
    default = "this is my first string"  
}

variable "multilinestring" {
    type = string   
    default = <<EOH
    this is a multi
    line
    string
   
   +++++ newline
    EOH
}

output  "myfirstoutput" {
  value = "${var.myfirststring}"
}

output  "mymultilineoutput" {
  value = "${var.multilinestring}"
}


  

