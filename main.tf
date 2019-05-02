module "project_test" {
    source          = "./modules/projects_init"
    organization_id = ""
}

module "project_resource" {
  source = "./modules/project_administration/project" 
  project_id = "${module.project_test.project_id}"
}
