variable "vpc_id" {
  type = string
}
variable "storage_size" {
  type    = number
  default = 20
}
variable "ssh_key" {
  type = string
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "name" {
  type    = string
  default = "wiah"
}
variable "asg_max_size" {
  type    = number
  default = 3
}
variable "asg_min_size" {
  type    = number
  default = 1
}
variable "asg_subnet_ids" {
  type = list(string)
}
variable "nginx_port" {
  type    = number
  default = 31555
}