output "haproxy_public_ip" {
  description = "The public IP address of the HAProxy instance"
  value       = format("http://%s", aws_instance.haproxy.public_ip)
}


output "nginx_public_ips" {
  description = "The public IP addresses of the Nginx instances"
  value       = aws_instance.nginx[*].public_ip
}
