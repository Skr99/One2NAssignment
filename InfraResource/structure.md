# Directory Structure

This project uses Terraform to provision infrastructure on AWS. Below is the directory structure for the project:


## Description of Files:

- **`main.tf`**: Contains the main configuration for provisioning resources in AWS, including EC2, VPC, and other resources.
- **`variables.tf`**: Defines input variables such as the S3 bucket name, instance type, etc.
- **`ec2.tf`**: Configures the EC2 instance that runs the Flask app.
- **`network.tf`**: Defines networking components like VPC, subnets, and other networking-related resources.
- **`iam.tf`**: Configures IAM roles and policies for the EC2 instance and other resources.
- **`s3.tf`**: Sets up the S3 bucket for storing and retrieving data.
- **`security.tf`**: Configures security groups and related security settings for the EC2 instance.
- **`user_data.sh`**: A shell script that runs when the EC2 instance is initialized, clones the Flask app from a Git repository, installs dependencies, and runs the Flask app as a daemon.
