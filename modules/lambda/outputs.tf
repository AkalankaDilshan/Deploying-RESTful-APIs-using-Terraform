output "lambda_name" {
  value = aws_lambda_function.Invoke_function.function_name
}

output "invoke_arn" {
  value = aws_lambda_function.Invoke_function.arn
}
