output "name" {
  value = "${var.name}"
}

output "name_cluster" {
value = "${var.env}.${var.name}"
}

output "name_servers" {
  value = "${data.aws_route53_zone.public.name_servers}"
}

output "public_zone_id" {
  value = "${data.aws_route53_zone.public.zone_id}"
}

output "state_store" {
  value = "s3://${aws_s3_bucket.state_store.id}"
}

output "public_subnet_ids" {
  value = "${module.subnets.public_subnet_ids}"
}

output "private_subnet_ids" {
  value = "${module.subnets.private_subnet_ids}"
}

output "nat_gateway_ids" {
  value = "${module.subnets.nat_gateway_ids}"
}

output "availability_zones" {
  value = "${module.subnets.availability_zones}"
}
