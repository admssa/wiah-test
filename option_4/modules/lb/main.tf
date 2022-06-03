resource "aws_lb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnet_ids

  enable_deletion_protection = false

}

resource "aws_lb_target_group" "default" {
  target_type          = "instance"
  port                 = var.tg_port
  protocol             = "TCP"
  vpc_id               = var.vpc_id
  deregistration_delay = 60

  health_check {
    interval            = 10
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_autoscaling_attachment" "asg_to_nlb" {
  autoscaling_group_name = var.asg_id
  lb_target_group_arn    = aws_lb_target_group.default.arn
}

resource "aws_lb_listener" "listner_80" {
  load_balancer_arn = aws_lb.this.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
  port     = 80
  protocol = "TCP"
}