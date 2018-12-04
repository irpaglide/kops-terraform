terraform {
  backend "s3" {
    bucket = "jmgarcia-terraform"
    key    = "truenorth-permanent"
    region = "us-east-2"
  }
}
