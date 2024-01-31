
# Manage the Application itself

data "azuread_client_config" "current" {}

resource "azuread_application" "example" {
  display_name     = var.display_name
  identifier_uris  = var.identifier_uris
  logo_image       = local.logo_image
  owners           = [data.azuread_user.owner.id]
  sign_in_audience = var.sign_in_audience
  description      = var.description

  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2





  }





  lifecycle {
    ignore_changes = [
      app_role,
      required_resource_access,
      optional_claims,
    ]
  }




  web {
    homepage_url  = "https://app.example.net"
    logout_url    = "https://app.example.net/logout"
    redirect_uris = ["https://app.example.net/account"]

    implicit_grant {
      access_token_issuance_enabled = var.access_token_issuance_enabled
      id_token_issuance_enabled     = var.id_token_issuance_enabled
    }
  }
}


# Application Roles to be added to the Application Registration




resource "random_uuid" "example" {
  for_each = local.app_roles

}


# Application Roles to be added to the Application Registration


resource "azuread_application_app_role" "example_administer" {
  application_id       = azuread_application.example.id
  for_each             = local.app_roles
  role_id              = random_uuid.example[each.key].id
  allowed_member_types = ["User"]
  description          = each.value.description
  display_name         = each.key
  value                = replace(each.value.value, "/[^a-zA-Z0-9]/", "")
}


# Create  Security Group for Application Role Assignment
resource "azuread_group" "example_administer_group" {
  for_each         = local.app_roles
  display_name     = "access_control_group_${each.key}_for_${var.display_name}"
  security_enabled = true
  owners           = [data.azuread_user.owner.id, data.azuread_client_config.current.object_id]
  description      = "Group for Application Role Assignment for ${each.key} for ${var.display_name} Application"
}




# Assign Application Roles to the Security Group
resource "azuread_app_role_assignment" "example_administer" {
  for_each            = local.app_roles
  principal_object_id = azuread_group.example_administer_group[each.key].id
  resource_object_id  = azuread_service_principal.example.id
  app_role_id         = azuread_application_app_role.example_administer[each.key].role_id
}


# Optional Claims to be added to the Application Registration

resource "azuread_application_optional_claims" "example" {
  application_id = azuread_application.example.id

  count = var.id_token != null || var.access_token != null || var.saml2_token != null ? 1 : 0
  # If Id token is not empty, create a block for it
  dynamic "id_token" {
    for_each = var.id_token != null ? { this = var.id_token } : {}
    iterator = token
    content {
      name                  = token.value[count.index].name
      essential             = token.value[count.index].essential
      source                = token.value[count.index].source
      additional_properties = token.value[count.index].additional_properties
    }

  }

  #create a dynamic block for each token in local.id_token
  dynamic "access_token" {
    for_each = var.access_token != null ? { this = var.access_token } : {}

    content {
      name                  = token.value[count.index].name
      essential             = token.value[count.index].essential
      source                = token.value[count.index].source
      additional_properties = token.value[count.index].additional_properties
    }

  }
  dynamic "saml2_token" {
    for_each = var.saml2_token != null ? { this = var.saml2_token } : {}
    iterator = token
    content {
      name                  = token.value[count.index].name
      essential             = token.value[count.index].essential
      source                = token.value[count.index].source
      additional_properties = token.value[count.index].additional_properties
    }

  }

}

# Add API Access to the Application Registration
resource "azuread_application_api_access" "example_resource_access" {
  for_each = local.api_access != null ? local.api_access : {}


  application_id = azuread_application.example.id
  api_client_id  = each.value.api_client_id
  role_ids       = each.value.role_ids
  scope_ids      = each.value.scope_ids

}



# Create a Service Principal for the Application Registration

resource "azuread_service_principal" "example" {
  depends_on                   = [azuread_application.example]
  client_id                    = azuread_application.example.client_id
  app_role_assignment_required = var.app_role_assignment_required
  owners                       = [data.azuread_user.owner.id]
  description                  = var.description
  feature_tags {
    custom_single_sign_on = true
  }
  preferred_single_sign_on_mode = var.preferred_single_sign_on_mode
  saml_single_sign_on {
    relay_state = var.relay_state
  }

}

# Create a Certificate for the Service Principal
resource "azuread_service_principal_certificate" "example" {
  count                = var.generate_certificate ? 1 : 0
  service_principal_id = azuread_service_principal.example.id
  type                 = "AsymmetricX509Cert"
  value                = file("cert.pem")
  end_date_relative    = "8760h" # 1 year
}

# Create a Secret for the Service Principal

resource "time_rotating" "example" {
  rotation_days = var.client_secret_rotation_days
}



resource "azuread_application_password" "example" {
  count                = var.generate_secret ? 1 : 0
  application_id = azuread_application.example.id
  rotate_when_changed = {
    rotation = time_rotating.example.id
  }
  
}



# Create and Assign Claims Mapping Policy

resource "azuread_claims_mapping_policy" "my_policy" {
  count        = local.create_claim_mapping_policy ? 1 : 0
  display_name = local.claims_mapping_policy.display_name
  definition   = local.claims_mapping_policy.definition
}

resource "azuread_service_principal_claims_mapping_policy_assignment" "app" {
  count                    = local.create_claim_mapping_policy ? 1 : 0
  claims_mapping_policy_id = azuread_claims_mapping_policy.my_policy[count.index].id
  service_principal_id     = azuread_service_principal.example.id
}


# Create Catalog if var.catalog is present
resource "azuread_access_package_catalog" "example" {
  count              = var.generate_catalog_access_package != false ? 1 : 0
  display_name       = "Catalog for ${var.display_name}"
  description        = "Catalog for ${var.display_name} to Assign and Add App Roles"
  published          = true
  externally_visible = false

}

#Assign all security groups we have created to our catalog if catalog is present
resource "azuread_access_package_resource_catalog_association" "example_groups" {
  for_each = var.generate_catalog_access_package != false ? azuread_group.example_administer_group : {}
  #count       = var.generate_catalog_access_package != false ? length(azuread_group.example_administer_group) : 0
  catalog_id             = azuread_access_package_catalog.example[0].id
  resource_origin_id     = each.value.id
  resource_origin_system = "AadGroup"
}

# Create an access package for each application role
resource "azuread_access_package" "application_roles" {
  #count       = var.generate_catalog_access_package != false ? length(local.app_roles) : 0
  for_each = var.generate_catalog_access_package != false ? local.app_roles : {}
  #count       = var.generate_catalog_access_package != false ? length(azuread_group.example_administer_group) : 0
  catalog_id   = azuread_access_package_catalog.example[0].id
  display_name = "Access Package for ${each.key} for ${var.display_name}"
  description  = "Access Package for ${each.key} for ${var.display_name}"
  hidden       = false
}

# Associate All Security Group to the respective security Package
resource "azuread_access_package_resource_package_association" "azuread_access_package_resource_catalog_association" {
  for_each                        = var.generate_catalog_access_package != false ? azuread_access_package_resource_catalog_association.example_groups : {}
  access_package_id               = azuread_access_package.application_roles[each.key].id
  catalog_resource_association_id = each.value.id

}

resource "azuread_access_package_assignment_policy" "example" {
  for_each          = var.generate_catalog_access_package != false ? azuread_access_package.application_roles : {}
  access_package_id = each.value.id
  display_name      = "assignment-policy for ${each.key} for ${var.display_name} Application"
  description       = "Assignment Policy for ${each.key} for ${var.display_name} Application"
  duration_in_days  = var.access_package_assignment_policy_duration_in_days

  requestor_settings {
    scope_type = "AllExistingDirectoryMemberUsers"
  }

  dynamic "approval_settings" {
    for_each = var.access_package_assignment_policy_approval_required != false ? [1] : []
    content {
      approval_required                = var.access_package_assignment_policy_approval_required
      requestor_justification_required = var.access_package_assignment_policy_approval_required

      approval_stage {
        approval_timeout_in_days            = 14
        alternative_approval_enabled        = true
        approver_justification_required     = true
        enable_alternative_approval_in_days = 7

        primary_approver {
          subject_type = "requestorManager"
        }
        alternative_approver {
          backup       = true
          subject_type = "groupMembers"
          object_id    = data.azuread_group.example_approver_group.id
        }
      }

    }



  }
}
