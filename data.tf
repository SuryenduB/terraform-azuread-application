data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
}

data "azuread_group" "example_approver_group" {
  display_name = var.approver_group_name

}

data "azuread_user" "owner" {
  user_principal_name = var.object_owner_upn
}