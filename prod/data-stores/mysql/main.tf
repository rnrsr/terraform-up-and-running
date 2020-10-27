terraform {
  backend "s3" {
    bucket = "terraform-richard"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "eu-north-1"

    dynamodb_table = "terraform-richard"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "database_instance" {
  source        = "../../../modules/data-stores/mysql"
  instance_name = "production"
  db_password   = "password"
}