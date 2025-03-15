output "k3s_lb_dns" {
  value = aws_lb.k3s_master_lb.dns_name
}

output "k3s_ingress_ip" {
  value = aws_eip.ingress_loadbalancer.public_ip
}