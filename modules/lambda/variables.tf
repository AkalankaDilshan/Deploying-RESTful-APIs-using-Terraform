variable "function_name" {
  description = "name for lambda function"
  type        = string
}

variable "zip_file_name" {
  description = "Lambda function zip file name"
  type        = string
}
variable "lambda_role_arn" {
  description = "The ARN of the IAM role for lambda"
  type        = string
}
