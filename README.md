# terraform-google-project-factory
Terraform Repository for Google Project Factory

# Terraform Google Project Factory using Google Cloud Provider

The purpose of this repository is to show case terraform Google Project
Factory. This demo will provision the following cloud resources associated to
corresponding terraform configurations:

| GCP Resource | Terraform Resource | Link to TerraHub Config |
|-----------------------|--------------------|-------------------------|
| Factory | google_factory | [factory/.terrahub.yml#L24](https://#L24) |
| Default Project | google_project_default | [project_default/.terrahub.yml#L8](https://#L7) |
| Default Service Account | google_project_default_service_account | [project_default_service_account/.terrahub.yml#L8](https://#L7) |
| Default Service Account Key | google_project_default_service_account_key | [project_default_service_account_key/.terrahub.yml#L9](https://#L9) |
| Default Service Account Role | google_project_default_service_account_add_role | [project_default_service_account_add_role/.terrahub.yml#L9](https://#L9) |
| Default Service Enable | google_project_default_service_enable | [project_default_service_enable/.terrahub.yml#L9](https://#L9) |
| Default Import | google_project_default_import | [project_default_import/.terrahub.yml#L9](https://#L9) |
| Project | google_project | [project/.terrahub.yml#L9](https://#L9) |
| Lien | google_lien | [lien/.terrahub.yml#L9](https://#L9) |
| Project service | google_project_service | [project_services/.terrahub.yml#L9](https://#L9) |

Follow below instructions to try this out in your own Google Cloud account.

## Login to Google Cloud

Run the following command in terminal:
```shell
gcloud beta auth application-default login
```

> NOTE: If you don't have Google Cloud CLI, check out this
[installation guide](https://cloud.google.com/sdk/install)

## Check if Python is available

Run the following command in terminal:
```shell
python -V
```

> NOTE: If you don't have Python, check out this
[installation guide](https://www.python.org)

## Check if third-party open source libraries is available

### Check if module googleapiclient is available

Run the following command in terminal:
```shell
python -c "import googleapiclient"
```

> NOTE: If you don't have Google Api Client, check out this
[installation guide](https://developers.google.com/api-client-library/python/start/installation)

### Check if module oauth2client is available

Run the following command in terminal:
```shell
python -c "import oauth2client"
```

> NOTE: If you don't have Oauth 2 Client, check out this
[installation guide](https://oauth2client.readthedocs.io/en/latest/)

## Terraform Automation and Orchestration Tool

The next couple of paragraphs are show casing the process of creating terraform
configurations using [TerraHub CLI](https://github.com/TerraHubCorp/terrahub).
We have opted to use YML format instead of HCL because it's easier and faster
to customize and automate terraform runs (see `terrahub component` command).

Run the following commands in terminal:
```shell
terrahub --help | head -3
```

Your output should be similar to the one below:
```
Usage: terrahub [command] [options]

terrahub@0.0.1 (built: 2018-04-07T19:15:39.787Z)
```

> NOTE: If you don't have TerraHub CLI, check out this
[installation guide](https://www.npmjs.com/package/terrahub)

## Build Terraform Configurations from Scratch

Run the following commands in terminal:
```shell
mkdir terraform-google-project-factory
cd terraform-google-project-factory
terrahub project -n terraform-google-project-factory
```

Your output should be similar to the one below:
```
✅ Project successfully initialized
```

> NOTE: If you want to jump directly to terraform automation part of the demo,
instead of creating `terraform-google-project-factory` from scratch, clone current
repository, follow the instructions for `Update TerraHub's Project Config` and then
jump down to `Visualize TerraHub Components`. This way you will fast forward
through terrahub components creation and customization, and switch directly to
automation part.

## Update TerraHub's Project Config

Run the following commands in terminal:
```shell
terrahub configure -c terraform.version=0.11.11
terrahub configure -c template.provider.google={}
```

Your output should be similar to the one below:
```
✅ Done
```

## Create TerraHub Components from Templates

Run the following command in terminal:
```shell
terrahub component -n factory -t google_factory \
&& terrahub component -n project_default -t google_project_default \
&& terrahub component -n project_default_service_account -t google_project_default_service_account -o ../google_project_default \
&& terrahub component -n project_default_service_account_key -t google_project_default_service_account_key -o ../project_default,../project_default_service_account \
&& terrahub component -n project_default_service_enable -t google_project_default_service_enable -o ../google_project_default \
&& terrahub component -n project_default_service_account_add_role -t google_project_default_service_account_add_role -o ../project_default,../project_default_service_account,../project_default_service_account_key,../project_default_service_enable \
&& terrahub component -n project_default_import -t google_project_default_import -o ../project_default,../project_default_service_account_add_role \
&& terrahub component -n project -t google_project -o ../project_default_import,../project_default,../project_default_service_account_key \
&& terrahub component -n project_services -t google_project_service -o  ../project \
&& terrahub component -n lien -t google_resource_manager_lien -o ../project
```

Your output should be similar to the one below:
```
✅ Done
```

## Customize TerraHub Component for Factory

Run the following commands in terminal:
```shell
terrahub component -n factory -t google_factory
terrahub configure -i factory -c component.template.terraform.backend.local.path='/tmp/.terrahub/local_backend/terraform-google-project-factory/factory/terraform.tfstate'
```

Your output should be similar to the one below:
```
✅ Done
```

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| factory_command | The command that will be run by `terrahub` in this component | string | run | no |
| factory_components | List of components to be run with his `tfvars` file | map || yes |

### Outputs


### Sample

```yml
...
factory_components:
    { COMPONENT NAME }: >-
        gs://{ STORAGE NAME }/{ STORAGE KEY }/default.tfvars
...
```

> NOTE: 

## Create Google Project Factory Modul

Run the following command in terminal:
```shell
./generator.sh
```
