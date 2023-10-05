terraform {
  cloud {
    organization = "Snort"

    workspaces {
      name = "terra-house-1"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}
provider "aws" {
  # Configuration options
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}

module "home_masuria_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.masuria.public_path
  content_version = var.masuria.content_version
}

resource "terratowns_home" "home-masuria" {
  name            = "How to spend your free time"
  description     = <<DESCRIPTION
Explore the breathtaking lakes, lush forests, and charming villages that make up the Masurian area.
DESCRIPTION
  domain_name     = module.home_masuria_hosting.cloudfront_url
  town            = "missingo"
  content_version = var.masuria.content_version
}

module "home_heroes_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.heroes.public_path
  content_version = var.heroes.content_version
}

resource "terratowns_home" "home-heroes" {
  name            = "Are you looking for a game?"
  description     = <<DESCRIPTION
Try this one!!! "Heroes of Might and Magic" is a beloved turn-based strategy game
DESCRIPTION
  domain_name     = module.home_heroes_hosting.cloudfront_url
  town            = "missingo"
  content_version = var.heroes.content_version
}