terraform {
  backend "s3" {
    bucket = "tatusl-polarsquad-tf-state"
    key    = "0.11/first-class-expressions"
    region = "eu-west-1"
  }
}
