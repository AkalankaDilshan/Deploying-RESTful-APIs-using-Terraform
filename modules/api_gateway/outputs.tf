output "api_url" {
  value       = aws_api_gateway_stage.dev_stage.invoke_url
  description = "API Gateway base URL"
}

