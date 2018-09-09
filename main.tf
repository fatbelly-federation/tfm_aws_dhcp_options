terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

provider "aws" {
  region = "${var.region}"
}


# get the VPC id
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket         = "${var.remote_state_bucket}"
    key            = "${var.region}/${var.vpc_name}/vpc/terraform.tfstate"
    region         = "${var.primary_state_region}"
    encrypt        = true
    dynamodb_table = "${var.dynamodb_table}"
  }
}
