#VPC#
resource "aws_vpc" "k3s_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "k3s_vpc"
    }
}
#IGW#
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.k3s_vpc.id
  tags = {
    Name = "K3S-IGW"
  }
}

resource "aws_eip" "ingress_loadbalancer" {
   domain = "vpc"
}

resource "aws_eip_association" "k3s_eip_assoc" {
  instance_id   = aws_instance.k3s_master.id
  allocation_id = aws_eip.ingress_loadbalancer.id
}

#Subnet#

resource "aws_subnet" "nodeip_public" {
  vpc_id = aws_vpc.k3s_vpc.id
  cidr_block = var.nodeip_public
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "nodeip_public"
  }
}

resource "aws_subnet" "nlb_public" {
  vpc_id                  = aws_vpc.k3s_vpc.id
  cidr_block              = var.nlb_public
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "nlb_public"
  }
}

#Route Table

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.k3s_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_rt"
  }
}

#Route Association

resource "aws_route_table_association" "public_rta1" {
  subnet_id = aws_subnet.nlb_public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rta2" {
  subnet_id = aws_subnet.nodeip_public.id
  route_table_id = aws_route_table.public_rt.id
}

