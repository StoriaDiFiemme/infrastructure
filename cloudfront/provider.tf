terraform {
  backend "s3" {
    bucket                  = "terraform-state.thedigitalcatonline.com"
    key                     = "storiadifiemme/cloudfront"
    region                  = "eu-west-1"
    dynamodb_table          = "terraform_state"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "personal"
  }
}

provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "personal"
  region                  = "eu-west-1"
}

provider "aws" {
  alias = "us-east-1"

  shared_credentials_file = "~/.aws/credentials"
  profile                 = "personal"
  region                  = "us-east-1"
}
