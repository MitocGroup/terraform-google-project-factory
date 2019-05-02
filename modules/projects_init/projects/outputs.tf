output "project_name" {
  value = "${local.project_name}"
}

output "project_id" {
  value = "${local.project_id}"
}

# output "project_names" {
#   value = "${local.project_names}"
# }

# output "project_ids" {
#   value = "${zipmap(
#     local.project_names, local.project_ids
#   )}"
# }

output "organization_id" {
  value = "${var.organization_id}"
}
