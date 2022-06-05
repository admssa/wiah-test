resource "aws_iam_instance_profile" "this" {
  name = replace(local.full_name, "RESOURCE", "profile")
  role = aws_iam_role.this.name
}

resource "aws_iam_role" "this" {
  name               = replace(local.full_name, "RESOURCE", "role")
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

resource "aws_iam_policy" "instance_access" {
  name        = replace(local.full_name, "RESOURCE", "policy")
  description = "Policy providing access from ec2 to kms and dynamodb"
  policy      = data.aws_iam_policy_document.access_logic.json
}

resource "aws_iam_role_policy_attachment" "access_policy_attachment" {
  policy_arn = aws_iam_policy.instance_access.arn
  role       = aws_iam_role.this.name
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "access_logic" {

  statement {
    sid     = "AllowDecryptAccessToKMSKey"
    effect  = "Allow"
    actions = ["kms:Decrypt"]
    resources = [
      aws_kms_key.this.arn
    ]
  }
  statement {

    sid    = "AccessToDynamoDB"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:PutItem"
    ]
    resources = [
      aws_dynamodb_table.this.arn
    ]
  }
}
