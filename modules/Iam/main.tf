data "aws_iam_policy_document" "polices" {
  version = 2008 - 10 - 17
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.polices.json
}

resource "aws_iam_policy_attachment" "lambda_basic_execution" {
  name       = "lambda-function-policy"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
