terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "blocked_processes_in_cassandra" {
  source    = "./modules/blocked_processes_in_cassandra"

  providers = {
    shoreline = shoreline
  }
}