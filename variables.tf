variable "region" {
  type = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "master_ami_id" {
  type = string
  default = "ami-04b4f1a9cf54c11d0"
}

variable "master_instance_type" {
  type = string
  default = "t2.medium"
}

variable "worker_ami_id" {
  type = string
  default = "ami-04b4f1a9cf54c11d0"
}

variable "worker_instance_type" {
  type = string
  default = "t2.medium"
}

variable "ssh_key_name" {
  type = string
  default = "server_ssh_key"
}

variable "nodeip_public" {
  type = string
  default = "10.0.128.0/20"
}

variable "nlb_public" {
  type = string
  default = "10.0.16.0/24"
}


variable "max_size" {
  type = string
  default = "7"
}


variable "min_size" {
  type = string
  default = "3"
}

variable "availability_zone" {
  type = string
  default = "us-east-1a"
}