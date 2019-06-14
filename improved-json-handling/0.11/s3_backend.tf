terraform {
  backend "s3" {
    bucket = "tatusl-polarsquad-tf-state"
    key    = "0.11/improved-json-handling"
    region = "eu-west-1"
  }
}
