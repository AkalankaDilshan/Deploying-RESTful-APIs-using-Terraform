resource "aws_api_gateway_rest_api" "my_api" {
  name        = "my-api"
  description = "student backend API gateway"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# resource for /Student API call
resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "Students"
}

# resource for /Student/{id} API call
resource "aws_api_gateway_resource" "student_id" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_resource.root.id
  path_part   = "{id}"
}

# Method for /Students (POST)
resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.root.id
  http_method   = "POST"
  authorization = "NONE"
}

# Method for /Students/{ID} (GET)
resource "aws_api_gateway_method" "student_id_get" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.student_id.id
  http_method   = "GET"
  authorization = "NONE"
}

# lambda integration for /Students
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.root.id
  http_method             = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

# lambda integration for /Students/{id}
resource "aws_api_gateway_integration" "lambda_integration_studentID" {
  rest_api_id             = aws_api_gateway_rest_api.my_api.id
  resource_id             = aws_api_gateway_resource.student_id.id
  http_method             = aws_api_gateway_method.student_id_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

# Responses for /Students (200)
resource "aws_api_gateway_method_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = aws_api_gateway_method_response.proxy.status_code
  depends_on = [
    aws_api_gateway_method.proxy,
    aws_api_gateway_integration.lambda_integration
  ]
}

# Responses for /Students/{id} (200)
resource "aws_api_gateway_method_response" "student_id_proxy" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.student_id.id
  http_method = aws_api_gateway_method.student_id_get.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "student_id_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.student_id.id
  http_method = aws_api_gateway_method.student_id_get.http_method
  status_code = aws_api_gateway_method_response.student_id_proxy.status_code
  depends_on = [
    aws_api_gateway_method.student_id_get,
    aws_api_gateway_integration.lambda_integration_studentID
  ]
}
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
    aws_api_gateway_integration.lambda_integration_studentID
  ]

  rest_api_id = aws_api_gateway_rest_api.my_api.id
  description = "deployment for API gateway"
}

resource "aws_api_gateway_stage" "dev_stage" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
  stage_name    = "dev"
  description   = "Development stage"
  variables = {
    "env" = "dev"
  }

}
