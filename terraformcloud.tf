terraform {
  backend "s3" {
    bucket         = "groupc-terraform-state-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
  }

} 

