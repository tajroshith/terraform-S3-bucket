terraform {
  backend "s3" {
    bucket = "xxxxx"
    key    = "terraform.tfstate"
    region = "us-east-1"
    access_key = "xxxxxx"
    secret_key = "xxxxxx"
  }
}

