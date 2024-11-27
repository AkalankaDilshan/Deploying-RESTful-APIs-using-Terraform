provider "aws" {
  region = "eu-north-1"
}

module "lambda_function" {
  source        = "./modules/lambda"
  function_name = "StudentDB_Backend"
}
