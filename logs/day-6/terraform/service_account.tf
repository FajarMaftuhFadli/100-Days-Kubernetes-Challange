resource "google_service_account" "gw-service-account" {
  project      = google_project.dev-gke-project.project_id
  account_id   = "gw-service-account-${random_id.random_suffix.hex}"
  display_name = "gw-service-account"
  description  = "A service account and a service account key are necessary to call the Google Wallet API. The service account is the identity that calls the Google Wallet API."
}

resource "google_service_account_key" "gw-service-account-key" {
  service_account_id = google_service_account.gw-service-account.name
}
