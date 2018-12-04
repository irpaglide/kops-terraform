resource "aws_route53_zone" "public" {
  name          = "${var.name}"
  force_destroy = true

  tags {
    Name        = "${var.name}-${var.env}-zone-public"
    Infra       = "${var.name}"
    Environment = "${var.env}"
    FromTerraform = "true"
  }
}

