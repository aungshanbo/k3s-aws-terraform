# Master Security Group #
resource "aws_security_group" "k3s_master_sg" {
  name   = "k3s-master-sg"
  vpc_id = aws_vpc.k3s_vpc.id

  #Allow SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["210.14.100.173/32"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 0
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "k3s_masterlb_sg" {
  name   = "k3s-masterlb-sg"
  vpc_id = aws_vpc.k3s_vpc.id

  # Allow inbound traffic from NLB for Kube API and Worker
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Master Security Group #
resource "aws_security_group" "k3s_worker_sg" {
  name   = "k3s-worker-sg"
  vpc_id = aws_vpc.k3s_vpc.id

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  #Allow SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "server_ssh_key" {
  key_name   = var.ssh_key_name
  public_key = file("~/.ssh/id_rsa.pub")
}