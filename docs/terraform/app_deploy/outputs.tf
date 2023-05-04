output "service_account" {
  value = google_pubsub_subscription.doit_easily_subscription.push_config[0].oidc_token[0].service_account_email
}

output "topic" {
  value = google_pubsub_subscription.doit_easily_subscription.topic
}

output "project" {
  value = google_pubsub_subscription.doit_easily_subscription.project
}
