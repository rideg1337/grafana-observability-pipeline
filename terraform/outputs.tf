output "public_ip" {
  value = aws_instance.grafana.public_ip
}

output "private_key_pem" {
  value     = tls_private_key.main.private_key_pem
  sensitive = true
}
