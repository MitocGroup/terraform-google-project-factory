variable "project_id" {
  type = "string"
  description = "Project id"
}

variable "service_account_name" {
  type = "string"
  description = "Service Account Name"
}

variable "file_path" {
  type = "string"
  description = "File path"
  default = "/root/.google/terraform_google_access.json"
}
