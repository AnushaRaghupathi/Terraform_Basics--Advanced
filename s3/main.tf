provider "aws" {
    region = "ap-south-1"
    profile = "Create profile"# create a profile by using key pairs to connect servers via SSH
  
}

resource "aws_s3_bucket" "example" {
    bucket = "bucket-tf-23-11"

    tags = {
        Environment = "Dev"
    }



}

resource "aws_s3_object" "testobject" {
  bucket = "${aws_s3_bucket.example.id}"
  key    = "testfile.txt"
  source = "../testobj/sampleobj.txt"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
    etag = "${md5(file("../testobj/sampleobj.txt"))}"
  # etag = filemd5("path/to/file") - while modifing the resource it will check etag 
}

    
  
