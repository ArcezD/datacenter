output "unifi-address" {
  value = "${aws_instance.unifi_controller.public_dns}:8080"
}