terraform {
  backend "s3" {
    bucket                  = "terraform-state.thedigitalcatonline.com"
    key                     = "storiadifiemme/routes"
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
