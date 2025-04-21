terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "CL030-DevOps"

    workspaces {
      prefix = "network-"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {}

locals {
    prefix = terraform.workspace
}

variable "vpc_cidr_block" {
  type = string
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "vpc-${local.prefix}"
  }
}