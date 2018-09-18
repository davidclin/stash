# by David Lin

provider "aws" {
  access_key = "1234567890"
  secret_key = "1234567890"
  region = "us-east-1"
}

resource "aws_instance" "test_box" {
  ami                    = "ami-12345678"          # AMI
  instance_type          = "${var.instance_type}"
  subnet_id              = "subnet-12345678"       # Private subnet 
  vpc_security_group_ids = ["${aws_security_group.open_to_inbound_ssh.id}"]
  key_name               = "${var.key_pair}"
#  iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.id}"

  ebs_block_device {
    device_name           = "/dev/sdf"
    volume_size           = "${var.disk_size}"
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = true
  }

  tags {
    Name = "Name of Instance"
    Owner = "davidlin"
    Team = "Bones Brigade"
  }
  provisioner "file" {   # copies file from TF to deployed instance
    source      = "append.sh"
    destination = "/home/ubuntu/append.sh"
    connection {
       type = "ssh"
       user = "ubuntu"
       private_key = "${file(var.pem_file)}"
    }
  }
  provisioner "remote-exec" {
    inline = [
        "sh /home/ubuntu/append.sh",     # script appends lines conf file
        "sudo service rsyslog restart"  # restart service
    ]
    connection {
       type = "ssh"
       user = "ubuntu"
       private_key = "${file(var.pem_file)}"
    }
  }
}


resource "aws_security_group" "open_to_inbound_ssh" {
  name        = "jenkins-inbound-ssh-https"
  description = "davidlin test security group"
  vpc_id      = "vpc-12345678"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Owner = "davidlin"
    Team = "IE"
  }
}
