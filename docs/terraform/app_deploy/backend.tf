terraform {
  backend "gcs" {
    bucket = "revieve-terraform-state"
    prefix = "terraform/doit/doit-marketplace-thehardway"
  }
}
