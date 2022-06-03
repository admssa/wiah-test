variable "vpc_id" {
  type = string
}

variable "name" {
  type    = string
  default = "wiah"
}

variable "tg_port" {
  type    = number
  default = 31555
}

variable "subnet_ids" {
  type = list(string)
}

variable "asg_id" {
  type = string
}