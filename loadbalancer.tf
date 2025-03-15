resource "aws_lb" "k3s_master_lb" {
    name = "k3s-master-lb"
    internal = false
    load_balancer_type = "network"
    enable_deletion_protection = false
    subnets = [ aws_subnet.nlb_public.id ]
    security_groups = [aws_security_group.k3s_masterlb_sg.id]
    tags = {
      Name = "k3s-master-lb"
    }
  
}
resource "aws_lb_target_group" "k3s_master_tg" {
  name = "k3s-master-tg"
  port = 6443
  protocol = "TCP"
  vpc_id = aws_vpc.k3s_vpc.id

  health_check {
    interval            = 10
    timeout             = 5
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "k3s_master_tga" {
  target_group_arn = aws_lb_target_group.k3s_master_tg.arn
  target_id = aws_instance.k3s_master.id
  port = 6443
}

resource "aws_lb_listener" "k3s_master_ls" {
  load_balancer_arn = aws_lb.k3s_master_lb.arn
  port = "6443"
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.k3s_master_tg.arn
  }
}