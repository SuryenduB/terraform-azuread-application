locals {
  app_roles  = { for role in var.app_roles : role.display_name => role }
  api_access = { for resource in var.api_access : resource.api_client_id => resource }
  optional_claims = {
    id_token     = var.id_token
    access_token = var.access_token
    saml2_token  = var.saml2_token
  }
  logo_image = filebase64(var.path_to_logo_image)
  #generate map from var.id_token
  claims_mapping_policy = {
    definition = [
      jsonencode(
        var.claims_mapping_policy

      )
    ],
    display_name = "EntraID Claims Mapping Policy - ${var.display_name}"
  }
  create_claim_mapping_policy = var.claims_mapping_policy != null ? true : false




}
