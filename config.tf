terraform {
  backend "s3" {
    bucket = "jmgarcia-terraform"
    key    = "truenorth"
    region = "us-east-2"
  }
}
