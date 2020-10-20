# terraform {
#   backend "s3" {
#     bucket = "terraform-richard"
#     key    = "stage/data-stores/mysql/terraform.tfstate"
#     region = "eu-north-1"

#     dynamodb_table = "terraform-richard"
#     encrypt        = true
#   }
# }

provider "aws" {
  region = "eu-north-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t3.micro"
  name = "example_database"
  username = "admin"

  # How should we set the password
  #password = data.aws_secretmanager_secret_version.db_password.secret_string
  password = var.db_password

  skip_final_snapshot = true
}

# data "aws_secretmanager_secret_version" "db_password" {
#   secret_id = "mysql-master-password-staging"
# }

output "address" {
  value = aws_db_instance.example.address
  description = "The DB endpoint"
}

output "port" {
  value = aws_db_instance.example.port
  description = "The port to use"
}