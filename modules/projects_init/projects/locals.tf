resource "random_id" "random_project_id_suffix" {
  # count       = "${length(var.project_names)}"
  byte_length = 4
}

locals {
  project_name = "${var.project_name}"
  project_id = "${format("%s-%s",var.project_name, random_id.random_project_id_suffix.hex)}"
  # project_ids = "${formatlist("%s-%s",var.project_names, random_id.random_project_ids_suffix.*.hex)}"
}