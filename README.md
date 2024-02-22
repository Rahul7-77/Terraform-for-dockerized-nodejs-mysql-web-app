# Dockerized Node.js-MySQL Web App Deployment with Terraform in AWS

## Overview

This project automates the hosting of a dockerized Node.js-MySQL web application on AWS using Terraform. It provisions the necessary infrastructure components including a Virtual Private Cloud (VPC), subnet, route table, internet gateway, and EC2 instance, and deploys a dockerized web application using Docker Compose on EC2 instance.

## Prerequisites

Before getting started, ensure you have the following prerequisites installed:

- Terraform
- Docker
- Docker Compose
- Node.js
- MySQL
- AWS CLI

## Usage

### 1. Setup AWS Credentials

- Generate access keys for an IAM user with sufficient permissions to provision AWS resources using Terraform.
- Store the access keys in the `~/.aws/credentials` file on your local machine.

### 2. Generate SSH Key Pair

- Generate an SSH key pair using the `ssh-keygen` command if you haven't already.
- Store the public and private keys in the `~/.ssh` directory on your local machine.

### 3. Clone the Repository

```bash
git clone https://github.com/your-username/your-repository.git
cd your-repository
```

### 4. Configure Terraform Variables

- Create a file named `terraform.tfvars` in the root directory of the repository.
- Define values for the variables specified in `variables.tf` based on your requirements.

### 5. Initialize Terraform

```bash
terraform init
```

### 6. Plan and Apply Terraform Changes

```bash
terraform plan
terraform apply --auto-approve
```

### 7. Access the Web Application

- Once Terraform has finished provisioning the infrastructure, Public IP address of EC2 instance will be shown in the terminal
- you can access the web application at port 3000 on public IP address of the EC2 instance in your web browser.

## License

This project is licensed under the MIT License.
