variable "display_name" {
  type        = string
  description = "The display name of the application."
}

variable "identifier_uris" {
  type        = list(string)
  description = "The URIs that identify the application."
}

variable "sign_in_audience" {
  type        = string
  default     = "AzureADMyOrg"
  description = "The audience for the sign-in request."
}

variable "path_to_logo_image" {
  type        = string
  default     = null
  description = "The path to the logo image of the application."
}

variable "app_roles" {
  type = list(object({
    description  = string
    display_name = string
    value        = string
  }))
  default     = []
  description = "The roles assigned to the application."
}

variable "id_token" {
  type = list(object({
    name                  = string
    essential             = bool
    source                = string
    additional_properties = list(string)
  }))
  default     = null
  description = "The ID token configuration."
}

variable "access_token" {
  type = list(object({
    name                  = string
    essential             = bool
    source                = string
    additional_properties = list(string)
  }))
  default     = null
  description = "The access token configuration."
}

variable "saml2_token" {
  type = list(object({
    name                  = string
    essential             = bool
    source                = string
    additional_properties = list(string)
  }))
  default     = null
  description = "The SAML2 token configuration."
}

variable "app_role_assignment_required" {
  type        = bool
  default     = true
  description = "Whether app role assignment is required."
}

variable "description" {
  type        = string
  default     = null
  description = "The description of the application."
}

variable "preferred_single_sign_on_mode" {
  type        = string
  default     = "notSupported"
  description = "The preferred single sign-on mode."
}

variable "relay_state" {
  type        = string
  default     = null
  description = "The relay state for single sign-on."
}

variable "generate_certificate" {
  type        = bool
  default     = false
  description = "Whether to generate a certificate for the application."
}

variable "generate_secret" {
  type        = bool
  default     = false
  description = "Whether to generate a secret for the application."
}

variable "claims_mapping_policy" {
  type = object({
    claims_schema = list(object({
      id              = string
      jwt_claim_type  = string
      Saml_Claim_Type = string
      source          = string
    }))
    include_basic_claim_set = string
    version                 = number
  })
  default     = null
  description = "The claims mapping policy for the application."
}

variable "generate_catalog_access_package" {
  type        = bool
  default     = false
  description = "Whether to generate a catalog access package for the application."
}

variable "access_package_assignment_policy_approval_required" {
  type        = bool
  default     = false
  description = "Whether approval is required for access package assignment policy."
}

variable "approver_group_name" {
  type        = string
  default     = "Administrators"
  description = "The name of the approver group for access package assignment policy."
}

variable "access_package_assignment_policy_duration_in_days" {
  type        = number
  default     = 14
  description = "The duration in days for access package assignment policy."
}

variable "object_owner_upn" {
  type        = string
  description = "The UPN of the object owner."
}

variable "api_access" {
  type = list(object({
    api_client_id = string
    role_ids      = list(string)
    scope_ids     = list(string)
  }))
  default     = null
  description = "The required API  access Permission for the  application."

}

variable "access_token_issuance_enabled" {
  type        = bool
  default     = false
  description = "Whether access token issuance is enabled."

}

variable "id_token_issuance_enabled" {
  type        = bool
  default     = false
  description = "Whether ID token issuance is enabled."

}

variable "client_secret_rotation_days" {
  type        = number
  default     = 14
  description = "The number of days after which client secret will be rotated."

}