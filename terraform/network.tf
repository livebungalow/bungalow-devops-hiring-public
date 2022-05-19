# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "main-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "${local.prefix}-main-vpc-1"
  cidr = "10.254.0.0/16"

  azs              = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets  = ["10.254.0.0/19", "10.254.64.0/19", "10.254.128.0/19"]
  public_subnets   = ["10.254.32.0/20", "10.254.96.0/20", "10.254.160.0/20"]
  database_subnets = ["10.254.48.0/21", "10.254.112.0/21", "10.254.176.0/21"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = {
    VPCName = "${local.prefix}-main-vpc-1"
  }

  vpc_tags = {
    Name = "${local.prefix}-main-vpc-1"
  }

  database_subnet_tags = {
    Name = "${local.prefix}-main-vpc-database-subnet"
    Tier = "Database"
  }
  public_subnet_tags = {
    Name = "${local.prefix}-main-vpc-public-subnet"
    Tier = "Public"
  }
  private_subnet_tags = {
    Name = "${local.prefix}-main-vpc-private-subnet"
    Tier = "Private"
  }
}

