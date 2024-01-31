output "application_group" {
  value       = azuread_group.example_administer_group
  description = "The Azure AD group associated with the application."
}

output "access_package" {
  value       = azuread_access_package.application_roles
  description = "The access package associated with the application."
}

output "azuread_access_package_resource_package_association" {
  value       = azuread_access_package_resource_package_association.azuread_access_package_resource_catalog_association
  description = "The association between the access package and the resource package in Azure AD."
}

output "azuread_application" {
  value       = azuread_application.example
  description = "The Azure AD application."

}

output "azuread_application_secret"{
  value = azuread_application_password.example
  sensitive = true
  description = "The Azure AD application secret Object."
}


