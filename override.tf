provider "aws" {
  region = "${var.region}"
}
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

