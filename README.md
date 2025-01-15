# One2NAssignment

## Project Overview
This project involves creating an API to list the contents of an S3 bucket and building the necessary infrastructure to run this API on a server using AWS services.

## Tasks
1. Create an API to list the S3 bucket content.
2. Build infrastructure to run the API on a server.

## File Structure
- **InfraResource/**
  - **main.tf**: Main Terraform file that sets up the overall AWS infrastructure, including VPC, IAM roles, S3 bucket, security group, and EC2 instance module.
  - **ec2.tf**: Defines the EC2 instance configuration.
  - **network.tf**: Sets up the VPC, subnet, and internet gateway.
  - **iam.tf**: Manages IAM roles and policies for the EC2 instance.
  - **s3.tf**: Configures the S3 bucket and its policy.
  - **securityGroup.tf**: Configures the security group for the EC2 instance.
  - **variables.tf**: Defines input variables used in the Terraform scripts.
- **s3ListContent.py**: The Flask application that interacts with AWS S3 to list the contents of a bucket.
- **user_data.sh**: Shell script that runs when the EC2 instance is initialized, clones the Flask app from a Git repository, installs dependencies, and runs the Flask app as a daemon.

# Steps to Deploy Infrastructure Using Terraform

## Prerequisites
1. **Install Terraform**: Ensure Terraform is installed on your local machine. You can download it from [Terraform Downloads](https://www.terraform.io/downloads).
2. **AWS CLI**: Install and configure the AWS CLI on your machine. You can follow the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

## AWS Authentication
1. **Configure AWS CLI**: Run the following command to configure your AWS CLI with your credentials:
    ```sh
    aws configure
    ```
   You will be prompted to enter your AWS Access Key ID, Secret Access Key, region, and output format.

## Terraform Commands
1. **Initialize Terraform**: Navigate to the directory containing your Terraform files and run the following command to initialize Terraform:
    ```sh
    terraform init
    ```

2. **Validate Configuration**: Validate the configuration files to ensure there are no errors:
    ```sh
    terraform validate
    ```

3. **Plan Infrastructure**: Generate and review an execution plan for Terraform:
    ```sh
    terraform plan
    ```

4. **Apply Configuration**: Apply the configuration to create the resources:
    ```sh
    terraform apply
    ```
   You will be prompted to confirm the action. Type `yes` and press Enter.

5. **Destroy Infrastructure (Optional)**: If you need to destroy the resources created by Terraform, run the following command:
    ```sh
    terraform destroy
    ```
   You will be prompted to confirm the action. Type `yes` and press Enter.

## Notes
- Ensure you have the necessary permissions to create resources in your AWS account.
- Review the plan output carefully before applying the changes to avoid any unintended modifications.

## Document Resources
1. [AWS Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
2. [Boto3 Documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)

## Tools
1. VSCode
2. ChatGPT
