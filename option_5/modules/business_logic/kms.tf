resource "aws_kms_key" "this" {
  tags = {
    Name = replace(local.full_name, "RESOURCE", "kms-key")
  }
}

resource "aws_kms_alias" "this" {
  name          = "alias/${replace(local.full_name, "RESOURCE", "kms-key")}"
  target_key_id = aws_kms_key.this.key_id
}