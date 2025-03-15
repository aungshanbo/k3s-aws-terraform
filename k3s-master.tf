resource "aws_instance" "k3s_master" {
  ami               = var.master_ami_id
  instance_type     = var.master_instance_type
  subnet_id         = aws_subnet.nodeip_public.id
  key_name          = var.ssh_key_name
  security_groups   = [aws_security_group.k3s_master_sg.id]
  availability_zone = var.availability_zone

  user_data = base64encode(templatefile("k3s_master.sh", {
    K3S_VERSION      = "v1.24.6+k3s1"
    K3S_CLUSTER_TOKEN = "Cz6ygIcRr3td6xKQZjYJVFmgkYn3SZ"
    K3S_SERVER_URL = aws_lb.k3s_master_lb.dns_name
    K3S_NODEIP = aws_eip.ingress_loadbalancer.public_ip
  }))

  depends_on = [aws_lb.k3s_master_lb,aws_eip.ingress_loadbalancer]
  tags = {
    Name = "k3s-master"
  }
}


