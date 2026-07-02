terraform {

  backend "s3" {

    bucket         = "cloudshield-terraform-state-01"
    key            = "cloudshield/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "cloudshield-terraform-lock"

    encrypt = true

  }

}