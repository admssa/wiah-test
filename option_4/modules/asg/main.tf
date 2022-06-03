resource "aws_autoscaling_group" "this" {
  name                = "${var.name}-${var.instance_type}"
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  vpc_zone_identifier = var.asg_subnet_ids


  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "this" {

  name_prefix            = "lt-${replace(var.name, "/[^A-Za-z0-9]/", "")}${replace(var.instance_type, "/[^A-Za-z0-9]/", "")}"
  instance_type          = var.instance_type
  image_id               = data.aws_ami_ids.ubuntu.ids[0]
  key_name               = var.ssh_key
  user_data              = base64encode(local.userdata)

  iam_instance_profile {
    name = aws_iam_instance_profile.default_profile.name
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_type           = "gp2"
      volume_size           = var.storage_size
      delete_on_termination = true
    }
  }
  ebs_optimized = true

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.this.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.name}-${var.instance_type}"
    }
  }
}

locals {
  userdata = <<USERDATA
#!/bin/bash
set -o xtrace
apt update -y
apt install -y nginx
systemctl enable nginx
systemctl start nginx
cat <<NGINX > /etc/nginx/sites-available/default
server {
        listen ${var.nginx_port} default_server;
        listen [::]:${var.nginx_port} default_server;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
        }
}
NGINX
systemctl reload nginx
USERDATA
}