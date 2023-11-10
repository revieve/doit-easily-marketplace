# the topic doit-easily publishes to (optional)
resource "google_pubsub_topic" "event_topic" {
  count   = var.event_topic_name != "" ? 1 : 0
  name    = "${var.event_topic_name}${local.codelab_suffix}"
  project = var.project_id
}

resource "google_pubsub_topic_iam_member" "event_topic_doit_easily_publisher" {
  count  = var.event_topic_name != "" ? 1 : 0
  member = "serviceAccount:${local.service_account_email}"
  role   = "roles/pubsub.publisher"
  topic  = google_pubsub_topic.event_topic[0].name
}

# The subscription that gets entitlement messages from Google
# To make this work you will need to add the service account in the marketplace product manually. To do it:
# - Go to the producer portal.
# - Select the product you are integrating.
# - In technical integration review hit the Edit button.
# - In section 2 cloud pub/sub integration link the service account provided in the outputs.
resource "google_pubsub_subscription" "doit_easily_subscription" {
  name     = "doit-easily${local.codelab_suffix}"
  topic    = local.topic
  provider = google.prod_impersonation # get created as doit-easily SA, not the user running this terraform
  #  this must be deployed into the marketplace project
  project = var.project_id
  push_config {
    push_endpoint = "${google_cloud_run_service.doit_easily_cloudrun_service.status[0].url}/v1/notification"
    oidc_token {
      service_account_email = local.service_account_email
    }
  }
  expiration_policy {
    # never expire the subscription
    ttl = ""
  }
}
