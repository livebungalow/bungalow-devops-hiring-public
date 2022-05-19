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

data "aws_ami" "ubuntu_ami" {
  most_recent = false
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20220511"]
  }
}
