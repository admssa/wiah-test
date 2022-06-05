resource "aws_dynamodb_table" "this" {
  hash_key = "Lock"
  name     = replace(local.full_name, "RESOURCE", "dynamodb")
  attribute {
    name = "Lock"
    type = "S"
  }
  read_capacity  = 20
  write_capacity = 20

}