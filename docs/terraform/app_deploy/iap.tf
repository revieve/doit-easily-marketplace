resource "google_project_service_identity" "iap_gsi" {
  provider = google-beta
  service = "iap.googleapis.com"
}

# resource "google_iap_brand" "iap_brand" {
#   application_title = var.brand_name
#   support_email     = var.brand_support_email
#   project           = var.project_number
# }

resource "google_iap_client" "iap_client" {
  display_name = var.iap_client_display_name
  brand        = "projects/516037450294/brands/516037450294"  
}