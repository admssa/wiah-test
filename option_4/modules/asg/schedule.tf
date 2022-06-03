resource "aws_autoscaling_schedule" "scale_up_day" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  scheduled_action_name  = "ScaleUPDay"
  min_size               = var.asg_max_size
  desired_capacity       = var.asg_max_size
  max_size               = var.asg_max_size
  recurrence             = "0 8 * * MON-FRI"
  time_zone              = "CET"
}

resource "aws_autoscaling_schedule" "scale_down_night" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  scheduled_action_name  = "ScaleDownNight"
  min_size               = 0
  desired_capacity       = 0
  max_size               = var.asg_min_size
  recurrence             = "0 18 * * MON-FRI"
  time_zone              = "CET"
}
