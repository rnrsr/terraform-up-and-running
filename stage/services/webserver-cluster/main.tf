terraform {
  backend "s3" {
    bucket = "terraform-richard"
    key    = "stage/webserver-cluster/terraform.tfstate"
    region = "eu-north-1"

    dynamodb_table = "terraform-richard"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "webserver_cluster" {
  source                 = "../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-staging"
  db_remote_state_bucket = "terraform-richard"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  instance_type          = "t3.micro"
  min_size               = 2
  max_size               = 10
}