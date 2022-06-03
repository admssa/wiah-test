output "asg_id" {
  value       = aws_autoscaling_group.this.id
  description = "Id of autoscaling group"
}
output "nlb_url" {
  value = module.nlb.lb_url
}