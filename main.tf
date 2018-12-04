module "vpc" {
  source   = "tf-aws-module-vpc"
  name     = "${var.name}"
  env      = "${var.env}"
  vpc_cidr = "${var.vpc_cidr}"

  tags {
    Infra             = "${var.name}"
    Environment       = "${var.env}"
    FromTerraform       = "true"
    KubernetesCluster = "${var.env}.${var.name}"
  }
}

module "subnets" {
  source              = "tf-aws-module-subnet"
  name                = "${var.name}"
  env                 = "${var.env}"
  vpc_id              = "${module.vpc.vpc_id}"
  vpc_cidr            = "${module.vpc.cidr_block}"
  internet_gateway_id = "${module.vpc.internet_gateway_id}"
  availability_zones  = "${var.azs}"

  tags {
    Infra             = "${var.name}"
    Environment       = "${var.env}"
    FromTerraform       = "true"
    KubernetesCluster = "${var.env}.${var.name}"
  }
}

data "aws_route53_zone" "public" {
  name         = "${var.name}"
}

resource "aws_s3_bucket" "state_store" {
  bucket        = "${var.name}-state"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags {
    Name        = "${var.name}-${var.env}-state-store"
    Infra       = "${var.name}"
    Environment = "${var.env}"
    FromTerraform = "true"
  }
}
