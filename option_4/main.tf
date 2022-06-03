module "instances" {
  source         = "./modules/asg"
  asg_subnet_ids = var.subnet_ids
  ssh_key        = var.ssh_key
  vpc_id         = var.vpc_id
}
