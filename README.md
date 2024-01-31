# terraform-azuread-application

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~> 2.47.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_access_package.application_roles](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/access_package) | resource |
| [azuread_access_package_assignment_policy.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/access_package_assignment_policy) | resource |
| [azuread_access_package_catalog.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/access_package_catalog) | resource |
| [azuread_access_package_resource_catalog_association.example_groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/access_package_resource_catalog_association) | resource |
| [azuread_access_package_resource_package_association.azuread_access_package_resource_catalog_association](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/access_package_resource_package_association) | resource |
| [azuread_app_role_assignment.example_administer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/app_role_assignment) | resource |
| [azuread_application.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_api_access.example_resource_access](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_api_access) | resource |
| [azuread_application_app_role.example_administer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_app_role) | resource |
| [azuread_application_optional_claims.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_optional_claims) | resource |
| [azuread_application_password.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_claims_mapping_policy.my_policy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/claims_mapping_policy) | resource |
| [azuread_group.example_administer_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_service_principal.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_certificate.example](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_certificate) | resource |
| [azuread_service_principal_claims_mapping_policy_assignment.app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_claims_mapping_policy_assignment) | resource |
| [random_uuid.example](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [time_rotating.example](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application_published_app_ids) | data source |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azuread_group.example_approver_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.owner](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_package_assignment_policy_approval_required"></a> [access\_package\_assignment\_policy\_approval\_required](#input\_access\_package\_assignment\_policy\_approval\_required) | Whether approval is required for access package assignment policy. | `bool` | `false` | no |
| <a name="input_access_package_assignment_policy_duration_in_days"></a> [access\_package\_assignment\_policy\_duration\_in\_days](#input\_access\_package\_assignment\_policy\_duration\_in\_days) | The duration in days for access package assignment policy. | `number` | `14` | no |
| <a name="input_access_token"></a> [access\_token](#input\_access\_token) | The access token configuration. | <pre>list(object({<br>    name                  = string<br>    essential             = bool<br>    source                = string<br>    additional_properties = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_access_token_issuance_enabled"></a> [access\_token\_issuance\_enabled](#input\_access\_token\_issuance\_enabled) | Whether access token issuance is enabled. | `bool` | `false` | no |
| <a name="input_api_access"></a> [api\_access](#input\_api\_access) | The required API  access Permission for the  application. | <pre>list(object({<br>    api_client_id = string<br>    role_ids      = list(string)<br>    scope_ids     = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_app_role_assignment_required"></a> [app\_role\_assignment\_required](#input\_app\_role\_assignment\_required) | Whether app role assignment is required. | `bool` | `true` | no |
| <a name="input_app_roles"></a> [app\_roles](#input\_app\_roles) | The roles assigned to the application. | <pre>list(object({<br>    description  = string<br>    display_name = string<br>    value        = string<br>  }))</pre> | `[]` | no |
| <a name="input_approver_group_name"></a> [approver\_group\_name](#input\_approver\_group\_name) | The name of the approver group for access package assignment policy. | `string` | `"Administrators"` | no |
| <a name="input_claims_mapping_policy"></a> [claims\_mapping\_policy](#input\_claims\_mapping\_policy) | The claims mapping policy for the application. | <pre>object({<br>    claims_schema = list(object({<br>      id              = string<br>      jwt_claim_type  = string<br>      Saml_Claim_Type = string<br>      source          = string<br>    }))<br>    include_basic_claim_set = string<br>    version                 = number<br>  })</pre> | `null` | no |
| <a name="input_client_secret_rotation_days"></a> [client\_secret\_rotation\_days](#input\_client\_secret\_rotation\_days) | The number of days after which client secret will be rotated. | `number` | `14` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the application. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the application. | `string` | n/a | yes |
| <a name="input_generate_catalog_access_package"></a> [generate\_catalog\_access\_package](#input\_generate\_catalog\_access\_package) | Whether to generate a catalog access package for the application. | `bool` | `false` | no |
| <a name="input_generate_certificate"></a> [generate\_certificate](#input\_generate\_certificate) | Whether to generate a certificate for the application. | `bool` | `false` | no |
| <a name="input_generate_secret"></a> [generate\_secret](#input\_generate\_secret) | Whether to generate a secret for the application. | `bool` | `false` | no |
| <a name="input_id_token"></a> [id\_token](#input\_id\_token) | The ID token configuration. | <pre>list(object({<br>    name                  = string<br>    essential             = bool<br>    source                = string<br>    additional_properties = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_id_token_issuance_enabled"></a> [id\_token\_issuance\_enabled](#input\_id\_token\_issuance\_enabled) | Whether ID token issuance is enabled. | `bool` | `false` | no |
| <a name="input_identifier_uris"></a> [identifier\_uris](#input\_identifier\_uris) | The URIs that identify the application. | `list(string)` | n/a | yes |
| <a name="input_object_owner_upn"></a> [object\_owner\_upn](#input\_object\_owner\_upn) | The UPN of the object owner. | `string` | n/a | yes |
| <a name="input_path_to_logo_image"></a> [path\_to\_logo\_image](#input\_path\_to\_logo\_image) | The path to the logo image of the application. | `string` | `null` | no |
| <a name="input_preferred_single_sign_on_mode"></a> [preferred\_single\_sign\_on\_mode](#input\_preferred\_single\_sign\_on\_mode) | The preferred single sign-on mode. | `string` | `"notSupported"` | no |
| <a name="input_relay_state"></a> [relay\_state](#input\_relay\_state) | The relay state for single sign-on. | `string` | `null` | no |
| <a name="input_saml2_token"></a> [saml2\_token](#input\_saml2\_token) | The SAML2 token configuration. | <pre>list(object({<br>    name                  = string<br>    essential             = bool<br>    source                = string<br>    additional_properties = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_sign_in_audience"></a> [sign\_in\_audience](#input\_sign\_in\_audience) | The audience for the sign-in request. | `string` | `"AzureADMyOrg"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_package"></a> [access\_package](#output\_access\_package) | The access package associated with the application. |
| <a name="output_application_group"></a> [application\_group](#output\_application\_group) | The Azure AD group associated with the application. |
| <a name="output_azuread_access_package_resource_package_association"></a> [azuread\_access\_package\_resource\_package\_association](#output\_azuread\_access\_package\_resource\_package\_association) | The association between the access package and the resource package in Azure AD. |
| <a name="output_azuread_application"></a> [azuread\_application](#output\_azuread\_application) | The Azure AD application. |
| <a name="output_azuread_application_secret"></a> [azuread\_application\_secret](#output\_azuread\_application\_secret) | The Azure AD application secret Object. |