resource "aws_security_group" "this" {
  name        = var.name
  description = "Security group for instances in the ${var.name}-${var.instance_type} ASG"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "nginx" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = var.nginx_port
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  to_port           = var.nginx_port
  type              = "ingress"
}
