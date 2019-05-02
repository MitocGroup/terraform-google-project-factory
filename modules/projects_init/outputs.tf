output "project_name" {
  value = "${var.project_name}"
}

output "organization_id" {
  value = "${var.organization_id}"
}

output "project_id" {
  value = "${module.project_create.project_id}"
}

output "service_account_name" {
  value = "${module.service_account_create.service_account_name}"
}

output "file_path" {
  value = "${module.service_account_key.file_path}"
}
