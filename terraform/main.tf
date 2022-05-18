# Terraform configuration
terraform {
  backend "s3" {
    bucket               = "tfstate-4378245783426"
    key                  = "devops-hiring/terraform.tfstate"
    workspace_key_prefix = "devops-hiring"
    region               = "us-west-2"
    encrypt              = true
    profile              = "sandbox"
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = "sandbox"
  default_tags {
    tags = {
      Environment   = local.environment
      Project       = var.project
      RepoName      = var.repo_name
      Automated     = var.automated
      ResourceGroup = var.resource_group
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }
  required_version = "~> 1.1.4"
}

data "aws_caller_identity" "current" {}

locals {
  account_id  = data.aws_caller_identity.current.account_id
  environment = terraform.workspace
  prefix      = "${lower(local.environment)}-${lower(var.project)}"
}

data "aws_ami" "amz_linux2_ami" {
  most_recent = false
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20220426.0-x86_64-ebs"]
  }
}
