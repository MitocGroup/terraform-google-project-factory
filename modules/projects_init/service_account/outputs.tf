output "service_account_name" {
  value = "${var.project_id}@${var.project_id}.iam.gserviceaccount.com"
}
