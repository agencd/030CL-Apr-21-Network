terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
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

module "iam" {
  source = "./modules/iam"
  groups = {
    "system_admins"   = ["system_admin_1", "system_admin_2", "system_admin_3"]
    "database_admins" = ["database_admin_1", "database_admin_2", "database_admin_3"]
    "read_only"       = ["read_only_1", "read_only_2", "read_only_3"]
  }
}

module "iam_heroes" {
  source = "./modules/iam"
  groups = {
    "system_admins"   = ["bambam", "fred", "wilma"]
    "database_admins" = ["jetsons", "spiderman", "batman"]
    "read_only"       = ["aquaman", "wonder_woman", "robin"]
  }
}