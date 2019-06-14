terraform {
  backend "s3" {
    bucket = "tatusl-polarsquad-tf-state"
    key    = "0.12/improved-json-handling"
    region = "eu-west-1"
  }
}
