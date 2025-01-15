resource "aws_instance" "flask_app" {
  ami                    = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2
  instance_type          = var.instance_type
  key_name               = var.instance_key_pair
  subnet_id              = module.vpc.subnet_id   # Referencing the subnet_id output from the VPC module
  security_groups        = [module.security.sg_id]  # Referencing the sg_id output from the Security module
  iam_instance_profile   = aws_iam_role.ec2_role.name  # Referencing the IAM role created in iam.tf
  associate_public_ip_address = true

  user_data = file("user_data.sh")

  tags = {
    Name = "FlaskAppInstance"
  }
}

output "public_ip" {
  value = aws_instance.flask_app.public_ip
}
