data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
}

data "azuread_service_principal" "TestAPI" {
  client_id = "6e3df5f1-974f-4305-9361-948f43cc43dd"
}

data "azuread_domains" "example" {
  only_initial = true
}

module "test_application" {
  source = "./modules/EntraIDApplication"

  display_name       = "Test Application"
  identifier_uris    = ["https://test-application"]
  sign_in_audience   = "AzureADMyOrg"
  path_to_logo_image = "GCN3.png"
  app_roles = [
    {
      description  = "Test Application Role"
      display_name = "Test Application"
      value        = "TestApplication Role"
    },
    {
      description  = "Test Application Role2"
      display_name = "Test Application Role 2"
      value        = "TestApplicationRole2"
    }
  ]
  app_role_assignment_required  = true
  description                   = "Test Application Description"
  preferred_single_sign_on_mode = "saml"
  claims_mapping_policy = {
    claims_schema = [
      {
        id              = "id"
        jwt_claim_type  = "name"
        Saml_Claim_Type = "name"
        source          = "user"
      }
    ]
    include_basic_claim_set = "true"
    version                 = "1"
  }

  generate_certificate                               = false
  generate_secret                                    = false
  generate_catalog_access_package                    = true
  approver_group_name                                = "Assigned Group"
  access_package_assignment_policy_approval_required = true
  object_owner_upn                                   = "SuryenduB@03z3s.onmicrosoft.com"
  api_access = [{
    api_client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
    role_ids = [data.azuread_service_principal.msgraph.app_role_ids["Group.Read.All"],
      data.azuread_service_principal.msgraph.app_role_ids["User.Read.All"],
    ]
    scope_ids = [
      data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.ReadWrite"],

    ]


    },
    {
      api_client_id = data.azuread_service_principal.TestAPI.client_id
      role_ids = [
        data.azuread_service_principal.TestAPI.app_role_ids["Files.ReadUser"],
      ]

      scope_ids = [
        data.azuread_service_principal.TestAPI.oauth2_permission_scope_ids["Files.Read"],

      ]
    },
  ]



}


output "access_package" {
  value = module.test_application.access_package
}

output "access_package_url" {
    value = [
      for access_package in module.test_application.access_package : "https://myaccess.microsoft.com/@${data.azuread_domains.example.domains.0.domain_name}#/access-packages/${access_package.id}"
    ]
    
}




output "azuread_application_id" {
  value = module.test_application.azuread_application.application_id
  
}

output "azuread_application_client_id" {
  value = module.test_application.azuread_application.client_id
  
}

output "azuread_application_object_id" {
  value = module.test_application.azuread_application.object_id
  
}


