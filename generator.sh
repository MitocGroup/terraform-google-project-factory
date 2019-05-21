#!/bin/bash
rm -rf ./.terrahub
rm ./.terrahub.yml
terrahub project -n terraform-google-project-factory -d ./
terrahub configure -c terraform.version=0.11.11
# terrahub configure -c template.provider.google={}
mkdir .terrahub
cd .terrahub
# Create project_default
terrahub component -n project_default -t google_project_default
terrahub configure -i project_default -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default/terraform.tfstate'
terrahub configure -i project_default -c component.template.variable -D -y
# Create project_default_service_account
terrahub component -n project_default_service_account -t google_project_default_service_account
terrahub configure -i project_default_service_account -c component.dependsOn[0]='../project_default'
terrahub configure -i project_default_service_account -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default_service_account/terraform.tfstate'
terrahub configure -i project_default_service_account -c component.template.data.terraform_remote_state.project_default.backend='local'
terrahub configure -i project_default_service_account -c component.template.data.terraform_remote_state.project_default.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default/terraform.tfstate'
terrahub configure -i project_default_service_account -c component.template.variable -D -y
terrahub configure -i project_default_service_account -c component.template.resource.null_resource.project_default_service_account.triggers.project_id='${data.terraform_remote_state.project_default.project_id}'
terrahub configure -i project_default_service_account -c component.template.resource.null_resource.project_default_service_account.provisioner[0].local-exec.when='create'
terrahub configure -i project_default_service_account -c component.template.resource.null_resource.project_default_service_account.provisioner[0].local-exec.command='python ${local.component["path"]}/scripts/apply.py'
terrahub configure -i project_default_service_account -c component.template.resource.null_resource.project_default_service_account.provisioner[0].local-exec.environment.project_id='${data.terraform_remote_state.project_default.project_id}'
terrahub configure -i project_default_service_account -c component.template.resource.null_resource.project_default_service_account.provisioner[0].local-exec.environment.service_account_name='${var.project_default_service_account_service_account_name}'
terrahub configure -i project_default_service_account -c component.template.output.service_account_name.value='${data.terraform_remote_state.project_default.project_id}@${data.terraform_remote_state.project_default.project_id}.iam.gserviceaccount.com'
# terrahub configure -i project_default_service_account -c component.template.variable.project_default_service_account_service_account_name.type='string'
# Create project_default_service_account_key
terrahub component -n project_default_service_account_key -t google_project_default_service_account_key
terrahub configure -i project_default_service_account_key -c component.dependsOn[0]='../project_default'
terrahub configure -i project_default_service_account_key -c component.dependsOn[1]='../project_default_service_account'
terrahub configure -i project_default_service_account_key -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default_service_account_key/terraform.tfstate'
terrahub configure -i project_default_service_account_key -c component.template.data.terraform_remote_state.project_default.backend='local'
terrahub configure -i project_default_service_account_key -c component.template.data.terraform_remote_state.project_default.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default/terraform.tfstate'
terrahub configure -i project_default_service_account_key -c component.template.data.terraform_remote_state.project_default_service_account.backend='local'
terrahub configure -i project_default_service_account_key -c component.template.data.terraform_remote_state.project_default_service_account.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default_service_account/terraform.tfstate'
terrahub configure -i project_default_service_account_key -c component.template.variable -D -y
terrahub configure -i project_default_service_account_key -c component.template.resource.null_resource.project_default_service_account_key.triggers.project_id='${data.terraform_remote_state.project_default.project_id}'
terrahub configure -i project_default_service_account_key -c component.template.resource.null_resource.project_default_service_account_key.triggers.service_account_name='${data.terraform_remote_state.project_default_service_account.service_account_name}'
terrahub configure -i project_default_service_account_key -c component.template.resource.null_resource.project_default_service_account_key.provisioner[0].local-exec.when='create'
terrahub configure -i project_default_service_account_key -c component.template.resource.null_resource.project_default_service_account_key.provisioner[0].local-exec.command='python ${local.component["path"]}/scripts/apply.py'
terrahub configure -i project_default_service_account_key -c component.template.resource.null_resource.project_default_service_account_key.provisioner[0].local-exec.environment.project_id='${data.terraform_remote_state.project_default.project_id}'
terrahub configure -i project_default_service_account_key -c component.template.resource.null_resource.project_default_service_account_key.provisioner[0].local-exec.environment.service_account_name='${data.terraform_remote_state.project_default_service_account.service_account_name}'
terrahub configure -i project_default_service_account_key -c component.template.resource.null_resource.project_default_service_account_key.provisioner[0].local-exec.environment.file_path='${var.project_default_service_account_key_file_path}'
# terrahub configure -i project_default_service_account_key -c component.template.variable.project_default_service_account_key_file_path.type='string'
# Create project_default_service_enable
terrahub component -n project_default_service_enable -t google_project_default_service_enable
terrahub configure -i project_default_service_enable -c component.dependsOn[0]='../project_default'
terrahub configure -i project_default_service_enable -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default_service_enable/terraform.tfstate'
terrahub configure -i project_default_service_enable -c component.template.data.terraform_remote_state.project_default.backend='local'
terrahub configure -i project_default_service_enable -c component.template.data.terraform_remote_state.project_default.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default/terraform.tfstate'
terrahub configure -i project_default_service_enable -c component.template.variable -D -y
terrahub configure -i project_default_service_enable -c component.template.resource.null_resource.project_default_service_enable.triggers.project_id='${data.terraform_remote_state.project_default.project_id}'
terrahub configure -i project_default_service_enable -c component.template.resource.null_resource.project_default_service_enable.provisioner[0].local-exec.when='create'
terrahub configure -i project_default_service_enable -c component.template.resource.null_resource.project_default_service_enable.provisioner[0].local-exec.command='python ${local.component["path"]}/scripts/apply.py'
terrahub configure -i project_default_service_enable -c component.template.resource.null_resource.project_default_service_enable.provisioner[0].local-exec.environment.project_id='${data.terraform_remote_state.project_default.project_id}'
terrahub configure -i project_default_service_enable -c component.template.resource.null_resource.project_default_service_enable.provisioner[0].local-exec.environment.service_name='${var.project_default_service_enable_service_name}'
# terrahub configure -i project_default_service_enable -c component.template.variable.project_default_service_enable_service_name.type='string'
# Create project_default_service_account_add_role
terrahub component -n project_default_service_account_add_role -t google_project_default_service_account_add_role
terrahub configure -i project_default_service_account_add_role -c component.dependsOn[0]='../project_default'
terrahub configure -i project_default_service_account_add_role -c component.dependsOn[1]='../project_default_service_account'
terrahub configure -i project_default_service_account_add_role -c component.dependsOn[2]='../project_default_service_account_key'
terrahub configure -i project_default_service_account_add_role -c component.dependsOn[3]='../project_default_service_enable'
terrahub configure -i project_default_service_account_add_role -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default_service_account_add_role/terraform.tfstate'
terrahub configure -i project_default_service_account_add_role -c component.template.data.terraform_remote_state.project_default.backend='local'
terrahub configure -i project_default_service_account_add_role -c component.template.data.terraform_remote_state.project_default.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default/terraform.tfstate'
terrahub configure -i project_default_service_account_add_role -c component.template.data.terraform_remote_state.project_default_service_account.backend='local'
terrahub configure -i project_default_service_account_add_role -c component.template.data.terraform_remote_state.project_default_service_account.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default_service_account/terraform.tfstate'
terrahub configure -i project_default_service_account_add_role -c component.template.variable -D -y
terrahub configure -i project_default_service_account_add_role -c component.template.resource.null_resource.project_default_service_account_add_role.triggers.project_id='${data.terraform_remote_state.project_default.project_id}'
terrahub configure -i project_default_service_account_add_role -c component.template.resource.null_resource.project_default_service_account_add_role.triggers.service_account_name='${data.terraform_remote_state.project_default_service_account.service_account_name}'
terrahub configure -i project_default_service_account_add_role -c component.template.resource.null_resource.project_default_service_account_add_role.provisioner[0].local-exec.when='create'
terrahub configure -i project_default_service_account_add_role -c component.template.resource.null_resource.project_default_service_account_add_role.provisioner[0].local-exec.command='python ${local.component["path"]}/scripts/apply.py'
terrahub configure -i project_default_service_account_add_role -c component.template.resource.null_resource.project_default_service_account_add_role.provisioner[0].local-exec.environment.project_id='${data.terraform_remote_state.project_default.project_id}'
terrahub configure -i project_default_service_account_add_role -c component.template.resource.null_resource.project_default_service_account_add_role.provisioner[0].local-exec.environment.service_account_name='${data.terraform_remote_state.project_default_service_account.service_account_name}'
# Create project_default_import
terrahub component -n project_default_import -t google_project_default_import
terrahub configure -i project_default_import -c component.dependsOn[0]='../project_default'
terrahub configure -i project_default_import -c component.dependsOn[1]='../project_default_service_account_add_role'
terrahub configure -i project_default_import -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default_import/terraform.tfstate'
terrahub configure -i project_default_import -c component.template.data.terraform_remote_state.project_default.backend='local'
terrahub configure -i project_default_import -c component.template.data.terraform_remote_state.project_default.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default/terraform.tfstate'
terrahub configure -i project_default_import -c component.template.variable -D -y
terrahub configure -i project_default_import -c component.template.resource.null_resource.project_default_import.triggers.project_id='${data.terraform_remote_state.project_default.project_id}'
terrahub configure -i project_default_import -c component.template.resource.null_resource.project_default_import.provisioner[0].local-exec.when='create'
terrahub configure -i project_default_import -c component.template.resource.null_resource.project_default_import.provisioner[0].local-exec.command='cd ${local.project["path"]} && terrahub import -c google_project.project=${data.terraform_remote_state.project_default.project_id} -i project'
terrahub configure -i project_default_import -c component.template.resource.null_resource.project_default_import.provisioner[0].local-exec.environment.project_id='${data.terraform_remote_state.project_default.project_id}'
# Create project
terrahub component -n project -t google_project
terrahub configure -i project -c component.dependsOn[0]='../project_default_import'
terrahub configure -i project -c component.dependsOn[1]='../project_default'
terrahub configure -i project -c component.dependsOn[2]='../project_default_service_account_key'
terrahub configure -i project -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project/terraform.tfstate'
terrahub configure -i project -c component.template.data.terraform_remote_state.project_default.backend='local'
terrahub configure -i project -c component.template.data.terraform_remote_state.project_default.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default/terraform.tfstate'
terrahub configure -i project -c component.template.data.terraform_remote_state.project_default_service_account_key.backend='local'
terrahub configure -i project -c component.template.data.terraform_remote_state.project_default_service_account_key.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_default_service_account_key/terraform.tfstate'
terrahub configure -i project -c component.template.resource.google_project.project.name='${data.terraform_remote_state.project_default.project_name}'
terrahub configure -i project -c component.template.resource.google_project.project.project_id='${data.terraform_remote_state.project_default.project_id}'
# Create project_services
terrahub component -n project_services -t google_project_service
terrahub configure -i project_services -c component.dependsOn[0]='../project'
terrahub configure -i project_services -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project_services/terraform.tfstate'
terrahub configure -i project_services -c component.template.data.terraform_remote_state.project.backend='local'
terrahub configure -i project_services -c component.template.data.terraform_remote_state.project.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project/terraform.tfstate'
terrahub configure -i project_services -c component.template.variable -D -y
terrahub configure -i project_services -c component.template.output -D -y
# terrahub configure -i project_services -c component.template.variable.project_services_activate_apis.type='list'
# terrahub configure -i project_services -c component.template.variable.project_services_disable_services_on_destroy.type='string'
terrahub configure -i project_services -c component.template.resource.google_project_service.project_services.count='${length(var.project_services_activate_apis)}'
terrahub configure -i project_services -c component.template.resource.google_project_service.project_services.project='${data.terraform_remote_state.project.thub_id}'
terrahub configure -i project_services -c component.template.resource.google_project_service.project_services.service='${element(var.project_services_activate_apis, count.index)}'
terrahub configure -i project_services -c component.template.resource.google_project_service.project_services.disable_on_destroy='${var.project_services_disable_services_on_destroy}'
# Create lien
terrahub component -n lien -t google_resource_manager_lien
terrahub configure -i lien -c component.dependsOn[0]='../project'
terrahub configure -i lien -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/lien/terraform.tfstate'
terrahub configure -i lien -c component.template.data.terraform_remote_state.project.backend='local'
terrahub configure -i lien -c component.template.data.terraform_remote_state.project.config.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/project/terraform.tfstate'
terrahub configure -i lien -c component.template.variable -D -y
terrahub configure -i lien -c component.template.output -D -y
# terrahub configure -i lien -c component.template.variable.lien.type='string'
# terrahub configure -i lien -c component.template.variable.lien_restrictions.type='list'
# terrahub configure -i lien -c component.template.variable.lien_origin.type='string'
# terrahub configure -i lien -c component.template.variable.lien_reason.type='string'
terrahub configure -i lien -c component.template.resource.google_resource_manager_lien.lien.count='${var.lien ? 1 : 0}'
terrahub configure -i lien -c component.template.resource.google_resource_manager_lien.lien.parent='projects/${data.terraform_remote_state.project.thub_id}'
terrahub configure -i lien -c component.template.resource.google_resource_manager_lien.lien.restrictions='${var.lien_restrictions}'
terrahub configure -i lien -c component.template.resource.google_resource_manager_lien.lien.origin='${var.lien_origin}'
terrahub configure -i lien -c component.template.resource.google_resource_manager_lien.lien.reason='${var.lien_reason}'
# Create factory
terrahub component -n factory -t google_factory
terrahub configure -i factory -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/factory/terraform.tfstate'
terrahub configure -i factory -c component.template.tfvars.factory_components.project_default='gs://data-lake-terrahub/tfvars/terraform-google-project-factory/project_default/default.tfvars'
terrahub configure -i factory -c component.template.tfvars.factory_components.project_default_service_account='gs://data-lake-terrahub/tfvars/terraform-google-project-factory/project_default_service_account/default.tfvars'
# terrahub configure -i factory -c component.template.tfvars.factory_components.project_default_service_account_key='gs://data-lake-terrahub/tfvars/terraform-google-project-factory/project_default_service_account_key/default.tfvars'
# terrahub configure -i factory -c component.template.tfvars.factory_components.project_default_service_enable='gs://data-lake-terrahub/tfvars/terraform-google-project-factory/project_default_service_enable/default.tfvars'
# terrahub configure -i factory -c component.template.tfvars.factory_components.project='gs://data-lake-terrahub/tfvars/terraform-google-project-factory/project/default.tfvars'
# terrahub configure -i factory -c component.template.tfvars.factory_components.lien='gs://data-lake-terrahub/tfvars/terraform-google-project-factory/lien/default.tfvars'
# terrahub configure -i factory -c component.template.tfvars.factory_components.project_services='gs://data-lake-terrahub/tfvars/terraform-google-project-factory/project_services/default.tfvars'
