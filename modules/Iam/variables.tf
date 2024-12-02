variable "role_name" {
  description = "name for Iam role"
  type        = string
}

variable "function_name" {
  type        = string
  description = "lambda function name"
}

variable "source_arn" {
  type        = string
  description = "execution arn"
}
