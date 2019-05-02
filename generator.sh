#!/bin/bash
rm -rf ./modules
rm ./.terrahub.yml
terrahub project -n terraform-google-project-factory -d ./
terrahub configure -c terraform.version=0.11.11
terrahub configure -c template.provider.google={}
mkdir modules
mkdir modules/gsuite_group
terrahub component -n gsuite_group -d ./modules/gsuite_group/
terrahub configure -i gsuite_group -c component.template.locals.domain='${var.domain != "" ? var.domain : data.google_organization.org.domain}'
terrahub configure -i gsuite_group -c component.template.locals.email='${format("%s@%s", var.name, local.domain)}'
terrahub configure -i gsuite_group -c component.template.data.google_organization.org.organization='${var.org_id}'
terrahub configure -i gsuite_group -c component.template.output.domain.value='${local.domain}'
terrahub configure -i gsuite_group -c component.template.output.domain.description='The domain of the groups organization.'
terrahub configure -i gsuite_group -c component.template.output.email.value='${local.email}'
terrahub configure -i gsuite_group -c component.template.output.email.description='The email address of the group.'
terrahub configure -i gsuite_group -c component.template.variable.domain.description='The domain name'
terrahub configure -i gsuite_group -c component.template.variable.domain.default=''
terrahub configure -i gsuite_group -c component.template.variable.name.description='The name of the group.'
terrahub configure -i gsuite_group -c component.template.variable.org_id.description='The organization ID.'
terrahub convert -i gsuite_group --to hcl -y
mkdir modules/project_services
terrahub component -n project_services -d ./modules/project_services/
terrahub configure -i project_services -c component.template.resource.google_project_service.project_services.count='${var.enable_apis ? length(var.activate_apis) : 0}'
terrahub configure -i project_services -c component.template.resource.google_project_service.project_services.project='${var.project_id}'
terrahub configure -i project_services -c component.template.resource.google_project_service.project_services.service='${element(var.activate_apis, count.index)}'
terrahub configure -i project_services -c component.template.resource.google_project_service.project_services.disable_on_destroy='${var.disable_services_on_destroy}'
terrahub configure -i project_services -c component.template.output.project_id.value='${element(concat(google_project_service.project_services.*.project, list("")),0)}'
terrahub configure -i project_services -c component.template.output.project_id.description='The GCP project you want to enable APIs on'
terrahub configure -i project_services -c component.template.variable.project_id.description='The GCP project you want to enable APIs on'
terrahub configure -i project_services -c component.template.variable.enable_apis.default='true'
terrahub configure -i project_services -c component.template.variable.enable_apis.description='Whether to actually enable the APIs. If false, this module is a no-op.'
terrahub configure -i project_services -c component.template.variable.activate_apis.type='list'
terrahub configure -i project_services -c component.template.variable.activate_apis.description='The list of apis to activate within the project'
terrahub configure -i project_services -c component.template.variable.disable_services_on_destroy.type='string'
terrahub configure -i project_services -c component.template.variable.disable_services_on_destroy.default='true'
terrahub configure -i project_services -c component.template.variable.disable_services_on_destroy.description='Whether project services will be disabled when the resources are destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_on_destroy'
terrahub convert -i project_services --to hcl -y
mkdir modules/app_engine
terrahub component -n app_engine -d ./modules/app_engine/
terrahub configure -i app_engine -c component.template.resource.google_app_engine_application.main.project='${var.project_id}'
terrahub configure -i app_engine -c component.template.resource.google_app_engine_application.main.location_id='${var.location_id}'
terrahub configure -i app_engine -c component.template.resource.google_app_engine_application.main.auth_domain='${var.auth_domain}'
terrahub configure -i app_engine -c component.template.resource.google_app_engine_application.main.serving_status='${var.serving_status}'
terrahub configure -i app_engine -c component.template.resource.google_app_engine_application.main.feature_settings='${var.feature_settings}'
terrahub configure -i app_engine -c component.template.output.name.value='${google_app_engine_application.main.name}'
terrahub configure -i app_engine -c component.template.output.name.description='Unique name of the app, usually apps/{PROJECT_ID}.'
terrahub configure -i app_engine -c component.template.output.url_dispatch_rule.value='${google_app_engine_application.main.url_dispatch_rule}'
terrahub configure -i app_engine -c component.template.output.url_dispatch_rule.description='A list of dispatch rule blocks. Each block has a domain, path, and service field.'
terrahub configure -i app_engine -c component.template.output.code_bucket.value='${google_app_engine_application.main.code_bucket}'
terrahub configure -i app_engine -c component.template.output.code_bucket.description='The GCS bucket code is being stored in for this app.'
terrahub configure -i app_engine -c component.template.output.default_hostname.value='${google_app_engine_application.main.default_hostname}'
terrahub configure -i app_engine -c component.template.output.default_hostname.description='The default hostname for this app.'
terrahub configure -i app_engine -c component.template.output.default_bucket.value='${google_app_engine_application.main.default_bucket}'
terrahub configure -i app_engine -c component.template.output.default_bucket.description='The GCS bucket content is being stored in for this app.'
terrahub configure -i app_engine -c component.template.variable.project_id.description='The project to enable app engine on.'
terrahub configure -i app_engine -c component.template.variable.location_id.description='The location to serve the app from.'
terrahub configure -i app_engine -c component.template.variable.location_id.default=''
terrahub configure -i app_engine -c component.template.variable.auth_domain.description='The domain to authenticate users with when using App Engines User API.'
terrahub configure -i app_engine -c component.template.variable.auth_domain.default=''
terrahub configure -i app_engine -c component.template.variable.serving_status.description='The serving status of the app.'
terrahub configure -i app_engine -c component.template.variable.serving_status.default='SERVING'
terrahub configure -i app_engine -c component.template.variable.feature_settings.description='A list of maps of optional settings to configure specific App Engine features.'
terrahub configure -i app_engine -c component.template.variable.feature_settings.default=[]
terrahub convert -i app_engine --to hcl -y
mkdir modules/gsuite_enabled
terrahub component -n gsuite_enabled -d ./modules/gsuite_enabled/
terrahub configure -i gsuite_enabled -c component.template.locals.group_name='${var.group_name != "" ? var.group_name : format("%s-editors", var.name)}'
terrahub configure -i gsuite_enabled -c component.template.resource.gsuite_group_member.service_account_sa_group_member.count='${var.sa_group != "" ? 1 : 0}'
terrahub configure -i gsuite_enabled -c component.template.resource.gsuite_group_member.service_account_sa_group_member.group='${var.sa_group}'
terrahub configure -i gsuite_enabled -c component.template.resource.gsuite_group_member.service_account_sa_group_member.email='${module.project-factory.service_account_email}'
terrahub configure -i gsuite_enabled -c component.template.resource.gsuite_group_member.service_account_sa_group_member.role='MEMBER'
terrahub configure -i gsuite_enabled -c component.template.resource.gsuite_group_member.service_account_sa_group_member.role='MEMBER'
terrahub configure -i gsuite_enabled -c component.template.resource.gsuite_group_member.service_account_sa_group_member.role='MEMBER'
