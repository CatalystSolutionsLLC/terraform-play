# What inputs this module accepts
variable "environment" {
  description = "Environment name (dev or prod)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_prefix" {
  description = "Prefix for all resource names"
  type        = string
}
