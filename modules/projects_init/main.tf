module "project_create" {
    source          = "./projects"
    project_name    = "${var.project_name}"
    organization_id = "${var.organization_id}"
}

module "service_account_create" {
    source     = "./service_account"
    project_id = "${module.project_create.project_id}"
}

module "service_account_key" {
    source                = "./service_account_key"
    project_id            = "${module.project_create.project_id}"
    service_account_name  = "${module.service_account_create.service_account_name}"
}

module "service_enable" {
    source        = "./service_enable"
    project_id    = "${module.project_create.project_id}"
}

module "service_account_add_role" {
    source                = "./service_account_add_role"
    project_id            = "${module.project_create.project_id}"
    service_account_name  = "${module.service_account_create.service_account_name}"
}
