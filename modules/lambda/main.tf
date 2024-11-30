resource "aws_lambda_function" "Invoke_function" {
  function_name = var.function_name
  runtime       = "python3.8"
  handler       = "index.lambda_handler"
  role          = var.lambda_role_arn

  #path to the lambda code package
  filename         = "${path.module}/${var.zip_file_name}"
  source_code_hash = filebase64sha256("${path.module}/${var.zip_file_name}")
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "lambda.amazonaws.com" }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_basic_execution" {
  name       = "${var.function_name}-policy"
  roles      = [aws_iam_role.lambda_role]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
