provider "aws" {
    region = "ap-south-1"
    profile = "rojamma-terraformlearning"
    #access_key = "AKIAYDWAA5IJTXOKN5H6"
    #secret_key = "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"
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


  

