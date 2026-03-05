# live/terragrunt.hcl
# This is the ROOT config - dev and prod both inherit from this

locals {
  subscription_id = "d1e489b1-e448-4154-b65e-b6ea6b5f3c5a"
  tenant_id       = "14b1cf45-d0fd-40cc-b8e6-8657154318be"
  location        = "westus2"
}

# This generates the Azure provider automatically for every module
# so we never have to repeat it
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
  subscription_id = "${local.subscription_id}"
  tenant_id       = "${local.tenant_id}"
  skip_provider_registration = true
}
EOF
}

# This configures remote state in your Azure storage account
# The key is generated automatically based on the module's folder path
remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "healthplanstfstate"
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}