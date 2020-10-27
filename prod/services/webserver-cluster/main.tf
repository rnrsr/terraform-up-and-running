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

module "webserver_cluster" {
  source                 = "../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "terraform-richard"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  autoscaling_group_name = module.webserver_cluster.asg_name
  scheduled_action_name  = "scale-out-during-business-hours"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 10
  recurrence             = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  autoscaling_group_name = module.webserver_cluster.asg_name
  scheduled_action_name  = "scale-in-at-night"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  recurrence             = "0 17 * * *"
}