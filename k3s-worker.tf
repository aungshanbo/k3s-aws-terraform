resource "aws_launch_template" "k3s_worker_lt" {
    image_id = var.worker_ami_id
    instance_type = var.worker_instance_type
    key_name = var.ssh_key_name

    network_interfaces {
      associate_public_ip_address = true 
      security_groups = [aws_security_group.k3s_worker_sg.id]
    }

    user_data = base64encode(templatefile("k3s_worker.sh", {
        K3S_VERSION      = "v1.24.6+k3s1"
        K3S_CLUSTER_TOKEN = "Cz6ygIcRr3td6xKQZjYJVFmgkYn3SZ"
        K3S_SERVER_URL = aws_lb.k3s_master_lb.dns_name
    }))

    depends_on = [aws_lb.k3s_master_lb]
}

resource "aws_autoscaling_group" "k3s_worker_asg" {
  vpc_zone_identifier = [ aws_subnet.nodeip_public.id ]
  desired_capacity = 3
  min_size = var.min_size
  max_size = var.max_size

  launch_template {
    id      = aws_launch_template.k3s_worker_lt.id
    version = "$Latest"
  }
  health_check_type = "EC2"
  health_check_grace_period = 300
  force_delete              = true
  tag {
    key                 = "Name"
    value               = "k3s-worker"
    propagate_at_launch = true
  }
}
