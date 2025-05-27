# Terraform SonarQube Deployment

This repository contains Terraform code to provision an **EC2 instance** running **SonarQube**, with remote **S3 backend** for storing Terraform state files.

## 📦 Features

* Deploys an EC2 instance on AWS.
* Automatically installs and configures SonarQube using a provisioning script.
* Uses an S3 bucket as a remote backend for Terraform state management.

---

## 🛠 Prerequisites

Before you begin, ensure you have the following:

* [Terraform](https://www.terraform.io/downloads)
* AWS CLI configured with necessary permissions
* An existing S3 bucket for backend state
* A valid AWS key pair (for SSH access)

---

## 📁 Project Structure

```bash
.
├── provider.tf           # AWS Terraform provider declaration.
├── main.tf               # Main Terraform configuration
├── variables.tf          # Input variables
├── outputs.tf            # Output values
├── backend.tf            # Backend configuration for S3
├── sg.tf                 # Security group configuration for Sonarqube
├── scripts/
│   └── install_sonarqube.sh  # Script to install and run SonarQube
└── README.md
```

---

## ⚙️ Configuration

### 1. Backend Setup

Configure the `backend.tf` file with your S3 bucket:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "sonarqube/terraform.tfstate"
    region         = "us-east-1"
  }
}
```

### 2. Variable Setup

Set your variables in a `terraform.tfvars` file or via the CLI:

```hcl
ami            = "ami-......."
instance_type  = "t2.medium"
tags           = "server_name"
port           = 9000
vpc_id         = "your_default_or_custom_vpc_id"
```

---

## 🚀 Deployment Steps

1. **Initialize Terraform**

   ```bash
   terraform init
   ```

2. **Preview the Plan**

   ```bash
   terraform plan
   ```

3. **Apply the Configuration**

   ```bash
   terraform apply
   ```

4. **Access SonarQube**

   * Once the EC2 instance is up, get the public IP from the output.
   * Open `http://<public-ip>:9000` in your browser.

5. **Access Server**

   * Once the EC2 instance is up, ssh_access from the output.
   * Run in the terminal for the current working directory.
   * If the server ami is for ubuntu, use username ubuntu, and update if different
   ```bash
   ssh -i ${aws_key_pair.generated_key.key_name}.pem ubuntu@${aws_instance.ubuntu_server.public_ip}
   ```

---

## 📤 Outputs

After applying, Terraform will output:

* `sonarqube_url`: URL to access the SonarQube dashboard
* `ec2_public_ip`: Public IP address of the EC2 instance

---

## 🧹 Cleanup

To destroy all resources created:

```bash
terraform destroy
```

---

## 📝 Notes

* The `install_sonarqube.sh` script installs dependencies and runs SonarQube in the background.
* Adjust instance size based on your expected usage (SonarQube requires at least 2GB RAM).