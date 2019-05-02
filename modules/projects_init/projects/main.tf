resource "null_resource" "gcp_project_apply" {
  # count = "${length(local.project_names)}"

  triggers = {
    project_id      = "${local.project_id}"
    # project_id      = "${element(local.project_ids, count.index)}"
    organization_id = "${var.organization_id}"
  }

  provisioner "local-exec" {
    when    = "create"
    command = "python ${path.module}/scripts/apply.py"
    environment = {
      project_name    = "${local.project_name}"
      project_id      = "${local.project_id}"
      # project_name    = "${element(local.project_names, count.index)}"
      # project_id      = "${element(local.project_ids, count.index)}"
      organization_id = "${var.organization_id}"
    }
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "echo 'info: destroy ignored because part of apply'"
  }
}
