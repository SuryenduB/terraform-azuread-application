# Example with Access Package, App Roles and API Permissions

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | =2.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | =2.47.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_test_application"></a> [test\_application](#module\_test\_application) | ./modules/EntraIDApplication | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/2.47.0/docs/data-sources/application_published_app_ids) | data source |
| [azuread_domains.example](https://registry.terraform.io/providers/hashicorp/azuread/2.47.0/docs/data-sources/domains) | data source |
| [azuread_service_principal.TestAPI](https://registry.terraform.io/providers/hashicorp/azuread/2.47.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/2.47.0/docs/data-sources/service_principal) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_package"></a> [access\_package](#output\_access\_package) | n/a |
| <a name="output_access_package_url"></a> [access\_package\_url](#output\_access\_package\_url) | n/a |
| <a name="output_azuread_application_client_id"></a> [azuread\_application\_client\_id](#output\_azuread\_application\_client\_id) | n/a |
| <a name="output_azuread_application_id"></a> [azuread\_application\_id](#output\_azuread\_application\_id) | n/a |
| <a name="output_azuread_application_object_id"></a> [azuread\_application\_object\_id](#output\_azuread\_application\_object\_id) | n/a |