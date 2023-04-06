output "ip_publico" {
  value = aws_instance.webserver.*.public_ip
}