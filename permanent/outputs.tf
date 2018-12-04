output "name_servers" {
  value = "${aws_route53_zone.public.name_servers}"
}

output "public_zone_id" {
  value = "${aws_route53_zone.public.zone_id}"
}
