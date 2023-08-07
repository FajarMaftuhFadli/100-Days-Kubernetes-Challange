resource "google_project_service" "google-wallet-api" {
  project = google_project.dev-gke-project.id
  service = "walletobjects.googleapis.com"
}
