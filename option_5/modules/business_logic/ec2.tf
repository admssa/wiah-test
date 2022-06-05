resource "aws_instance" "this" {

  ami           = data.aws_ami_ids.ubuntu.ids[0]
  instance_type = "t3.micro"

  tags = {
    Name = replace(local.full_name, "RESOURCE", "ec2")
  }
  iam_instance_profile = aws_iam_instance_profile.this.name
}
