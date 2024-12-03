data "aws_iam_policy_document" "polices" {
  version = "2012-10-17"
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    #resources = ["*"] #["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}"]
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

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.source_arn}/*/*/*"
}

# data "aws_caller_identity" "current" {}
