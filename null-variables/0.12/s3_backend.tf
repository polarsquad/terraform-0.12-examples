terraform {
  backend "s3" {
    bucket = "tatusl-polarsquad-tf-state"
    key    = "0.12/null-resource"
    region = "eu-west-1"
  }
}
