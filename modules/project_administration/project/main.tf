resource "google_project" "gcp_project_update_destroy" {
  count           = "${var.project_id != "" ? 1 : 0}"
  name            = "${var.project_name}"
  project_id      = "${var.project_id}"
  org_id          = "${var.organization_id}"
  billing_account = "${var.billing_account}"
}