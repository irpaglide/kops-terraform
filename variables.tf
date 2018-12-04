variable "name" {
  default = "truenorth.jmgarciatest.com"
}

variable "ecr_repo_name" {
  default = "weatherapp"
}

variable "region" {
  default = "us-east-2"
}

variable "azs" {
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
  type    = "list"
}

variable "env" {
  default = "test"
}

variable "vpc_cidr" {
  default = "10.150.0.0/16"
}
