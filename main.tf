provider "aws" {
  region = var.region
}

module "lambda_function" {
  source          = "./modules/lambda"
  function_name   = "StudentDB_Backend"
  lambda_role_arn = module.Iam_role.function_role_arn
}


module "Iam_role" {
  source        = "./modules/Iam"
  role_name     = "lambdaFunctionRole"
  function_name = module.lambda_function.lambda_name
  source_arn    = module.lambda_function.invoke_arn
}

module "API_gateway" {
  source            = "./modules/api_gateway"
  lambda_invoke_arn = module.lambda_function.invoke_arn
  region            = var.region
}
