# live/dev/terragrunt.hcl
# Dev environment - inherits everything from the root config

include "root" {
  path = find_in_parent_folders()
}

locals {
  environment = "dev"
}

terraform {
  source = "../../modules//function-app"
}

inputs = {
  environment     = local.environment
  location        = "westus2"
  resource_prefix = "healthplans"
}