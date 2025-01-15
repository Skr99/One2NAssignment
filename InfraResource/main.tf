provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./network.tf"
}

module "iam" {
  source = "./iam.tf"
}

module "s3" {
  source = "./s3.tf"
  bucket_name = var.bucket_name
}

module "security" {
  source = "./security.tf"
}

module "ec2" {
  source = "./ec2.tf"
  instance_type = var.instance_type
  key_pair      = var.instance_key_pair
  bucket_name   = var.bucket_name
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.subnet_id
  sg_id         = module.security.sg_id
  iam_role      = module.iam.ec2_role_name
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}
