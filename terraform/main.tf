provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "default_sg" {
  name        = "default_sg"
  description = "Default security group for HAProxy and Nginx instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "haproxy" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.default_sg.id]

  tags = {
    Name = "haproxy"
  }
}


resource "aws_instance" "nginx" {
  count                  = 2
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.default_sg.id]

  tags = {
    Name = "nginx-${count.index + 1}"
  }
}

resource "null_resource" "update_hosts_file" {
  depends_on = [aws_instance.haproxy, aws_instance.nginx]

  provisioner "local-exec" {
    command = "echo '[haproxy]\n${aws_instance.haproxy.public_ip}\n\n[nginx_servers]' > ../ansible/hosts.ini && echo '${aws_instance.nginx[0].public_ip}\n${aws_instance.nginx[1].public_ip}' >> ../ansible/hosts.ini"
  }
}

resource "null_resource" "ansible" {
provisioner "local-exec" {

  working_dir = "/home/kasdal/Infrastructure/ansible"
  command = "ansible-playbook -i hosts.ini site.yml --private-key=new_key"
}
}