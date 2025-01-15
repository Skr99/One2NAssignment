variable "region" {
  description = "AWS region for resources"
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "instance_key_pair" {
  description = "SSH key pair for EC2 instance"
  type        = string
}
