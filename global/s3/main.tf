terraform {
  backend "s3" {
    bucket = "terraform-richard"
    key    = "global/s3/terraform.tfstate"
    region = "eu-north-1"

    dynamodb_table = "terraform-richard"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "tbg_terraform_state" {
  bucket = "terraform-richard"

  # Prevent accidental deletion of the bucket
  lifecycle {
    prevent_destroy = true
  }

  # Enable versioning so the full history is preserved
  versioning {
    enabled = true
  }

  # Enable server-side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-richard"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
