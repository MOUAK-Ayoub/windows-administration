terraform {

  required_version = ">=1.3"

  backend "s3" {
    profile = "default"
    region  = "us-east-1"
    bucket  = "terraformstatefile2024"
    key     = "terraformstatefile"

  }
}
