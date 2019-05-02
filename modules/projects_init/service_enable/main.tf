resource "null_resource" "gcp_service_enable" {
  triggers = {
    project_id   = "${var.project_id}"
    service_name = "${var.service_name}"
  }

  provisioner "local-exec" {
    when    = "create"
    command = "python ${path.module}/scripts/apply.py"
    environment = {
      project_id   = "${var.project_id}"
      service_name = "${var.service_name}"
    }
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "echo 'info: destroy ignored because part of apply'"
  }
}
