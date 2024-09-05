terraform {
  backend "gcs" {
    bucket = "labzz-challenge"
    prefix = "tfstate/sa-east1-a"
  }
}