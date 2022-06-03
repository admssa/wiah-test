module "nlb" {
  source     = "../lb"
  asg_id     = aws_autoscaling_group.this.id
  subnet_ids = var.asg_subnet_ids
  vpc_id     = var.vpc_id
}