provider "aws" {
  region = var.region
}

provider "aws" {
  alias = "eu-west-2"
  region = "eu-west-2"
  
}
provider "random" {}

data "aws_caller_identity" "current" {}