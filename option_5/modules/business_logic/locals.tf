locals {
  full_name = "${var.name}-RESOURCE-${var.env}-${data.aws_region.current.name}"
}