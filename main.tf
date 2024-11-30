provider "aws" {
  region = "eu-north-1"
}

module "lambda_function" {
  source          = "./modules/lambda"
  function_name   = "StudentDB_Backend"
  lambda_role_arn = modules.Iam.function_role_arn
}


module "Iam_role" {
  source    = "./modules/Iam"
  role_name = "lambdaFunctionRole"
}
