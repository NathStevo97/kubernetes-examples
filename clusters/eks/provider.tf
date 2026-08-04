terraform {
  required_version = ">= 1.14.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.37.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}
