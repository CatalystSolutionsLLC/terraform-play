# live/prod/terragrunt.hcl
# Prod environment - same modules, same structure, different environment tag

include "root" {
  path = find_in_parent_folders()
}

locals {
  environment = "prod"
}

terraform {
  source = "../../modules//function-app"
}

inputs = {
  environment     = local.environment
  location        = "westus2"
  resource_prefix = "healthplans"
}