.
├── main.tf            # Main configuration file to provision resources
├── variables.tf       # Variables file to define inputs (e.g., bucket name, instance type)
├── ec2.tf             # EC2 instance configuration file
├── network.tf         # Networking resources (VPC, Subnets, etc.)
├── iam.tf             # IAM roles and policies configuration
├── s3.tf              # S3 bucket configuration
├── security.tf        # Security Groups and related settings
└── user_data.sh       # EC2 user-data script (runs Flask app)
