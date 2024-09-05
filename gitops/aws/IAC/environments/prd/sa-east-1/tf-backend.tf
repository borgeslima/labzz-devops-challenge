terraform {
  backend "s3" {
    bucket = "labzz-flowise"
    key = "tfstate/terraform.tfstate"
    region = "sa-east-1"
  }
}