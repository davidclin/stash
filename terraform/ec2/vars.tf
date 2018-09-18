# Copyright 2018 Toyota Research Institute. All rights reserved.

variable "name" {
  description = "Team name, appended to jenkins instance as a tag."
  default = "Terraform Instance david.lin.ctr"
}

variable "instance_type" {
  description = "AWS instance type to launch Jenkins Master on."
  default = "t2.micro"
}

variable "disk_size" {
  description = "Disk size in GB for the Jenkins Master (default 300 GB)."
  default = 300
}

variable "key_pair" {
  description = "Name of key pair to attach to the Jenkins Master instance."
  default = "david.lin.ctr"
}

variable "admin_email" {
  description = "Valid Email address for admin user (including @tri.global)."
  default = "david.lin.ctr@tri.global.com"
}

variable "pem_file" {
  description = "ec2 instance pem file to connect for post provision (full path to file)."
  default = "davidlinctr.pem"
}

variable "region" {
  description = "Region where bucket located."
  default = "us-east-1"
}
