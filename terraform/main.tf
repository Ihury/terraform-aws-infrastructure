provider "aws" {
  region = "us-east-1"
}

module "aws_humangov_infrastructure" {
  source          = "./modules/aws_humangov_infrastructure"
  public_key_path = "${path.root}/ec2-key.pub"

  for_each   = toset(var.states)
  state_name = each.value
}