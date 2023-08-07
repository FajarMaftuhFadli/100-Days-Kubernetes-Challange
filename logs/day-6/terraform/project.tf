resource "google_project" "dev-gke-project" {
  name                = "dev-gke"
  project_id          = "dev-gke-${random_id.random_suffix.hex}"
  folder_id           = var.folder_id
  billing_account     = var.billing_account_id
  auto_create_network = false
}

resource "google_project_organization_policy" "disableServiceAccountKeyCreation-policy" {
  project    = google_project.dev-gke-project.project_id
  constraint = "iam.disableServiceAccountKeyCreation"

  boolean_policy {
    enforced = false
  }
}
