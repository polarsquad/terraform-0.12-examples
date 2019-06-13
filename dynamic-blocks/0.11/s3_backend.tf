terraform {
  backend "s3" {
    bucket = "tatusl-polarsquad-tf-state"
    key    = "0.11/dynamic-blocks"
    region = "eu-west-1"
  }
}
