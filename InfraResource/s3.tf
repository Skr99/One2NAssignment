resource "aws_s3_bucket" "flask_app_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "FlaskAppBucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_policy" "flask_app_bucket_policy" {
  bucket = aws_s3_bucket.flask_app_bucket.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "s3:ListBucket"
        Effect    = "Allow"
        Principal = "*"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.flask_app_bucket.bucket}"
      },
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Principal = "*"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.flask_app_bucket.bucket}/*"
      }
    ]
  })
}

output "bucket_name" {
  value = aws_s3_bucket.flask_app_bucket.bucket
}
