provider "google" {
  project = "revieve-public"
}

# https://cloud.google.com/docs/terraform/resource-management/store-state
terraform {
  backend "gcs" {
    bucket = "revieve-terraform-state"
    prefix = "terraform/dns/gcpmarketplace.revieve.com"
  }
}

resource "google_dns_managed_zone" "dns_zone" {
  name     = "gcpmarketplace"
  dns_name = "gcpmarketplace.revieve.com."
}
