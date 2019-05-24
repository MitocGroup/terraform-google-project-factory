# terraform-google-project-factory
Terraform Repository for Google Project Factory

# Terraform Google Project Factory using Google Cloud Provider

The purpose of this repository is to show case terraform Google Project
Factory. This demo will provision the following cloud resources associated to
corresponding terraform configurations:

| GCP Resource | Terraform Resource | Link to TerraHub Config |
|-----------------------|--------------------|-------------------------|
| Factory | google_factory | [.terrahub/factory/.terrahub.yml#L24](https://#L24) |
| Default Project | google_project_default | [.terrahub/project_default/.terrahub.yml#L8](https://#L7) |
| Default Service Account | google_project_default_service_account | [.terrahub/project_default_service_account/.terrahub.yml#L8](https://#L7) |
| Default Service Account Key | google_project_default_service_account_key | [.terrahub/project_default_service_account_key/.terrahub.yml#L9](https://#L9) |
| Default Service Account Role | google_project_default_service_account_add_role | [.terrahub/project_default_service_account_add_role/.terrahub.yml#L9](https://#L9) |
| Default Service Enable | google_project_default_service_enable | [.terrahub/project_default_service_enable/.terrahub.yml#L9](https://#L9) |
| Default Import | google_project_default_import | [.terrahub/project_default_import/.terrahub.yml#L9](https://#L9) |
| Project | google_project | [.terrahub/project/.terrahub.yml#L9](https://#L9) |
| Lien | google_lien | [.terrahub/lien/.terrahub.yml#L9](https://#L9) |
| Project service | google_project_service | [.terrahub/project_services/.terrahub.yml#L9](https://#L9) |

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

## Create Google Project Factory Modul

Run the following command in terminal:
```shell
./generator.sh
```
