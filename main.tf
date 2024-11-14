terraform {
  required_version = ">= 1.5.0"
}

# variable "raw_authorizers" {
#   description = "Map of API gateway authorizers"
#   type = map(object({
#     authorizer_type                  = string
#     name                             = string
#     identity_sources                 = list(string)
#     authorizer_result_ttl_in_seconds = optional(number)
#     audience = list(string)
#     issuer   = string
#   }))
#   default     = {}
# }

variable "base64_data" {
  description = "Base64 encoded data"
  type = string
  default = "ew0KICAiSldUQXV0aG9yaXplcjEiOiB7DQogICAgImF1dGhvcml6ZXJfdHlwZSI6ICJKV1QiLA0KICAgICJuYW1lIjogIkpXVEF1dGhvcml6ZXIxIiwNCiAgICAiaWRlbnRpdHlfc291cmNlcyI6IFsiJHJlcXVlc3QuaGVhZGVyLkF1dGhvcml6YXRpb24iXSwNCiAgICAiYXV0aG9yaXplcl9yZXN1bHRfdHRsX2luX3NlY29uZHMiOiAwLA0KICAgICJhdWRpZW5jZSI6IFsidGVzdC1hdWRpZW5jZSJdLA0KICAgICJpc3N1ZXIiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tLyINCiAgfQ0KfQ=="
}

variable "test_data" {
  description = "test data"
  type = string
  default = ""
}

locals {
  decoded_data = jsondecode(base64decode(var.base64_data))

  test_data = jsondecode(base64decode(var.test_data))
  # clean_identity_sources = {
  #   for authorizer_key, authorizer_config in var.raw_authorizers:
  #   authorizer_key => {
  #     for key, value in authorizer_config:
  #     key => [for item in value: replace(item, "\\$", "$")]
  #     if key == "identity_sources"
  #   }
  # }

  # authorizers = {
  #   for k, v in var.raw_authorizers : k => merge(v, local.clean_identity_sources[k] != null ? local.clean_identity_sources[k] : {})
  # }
}

# output "clean_identity_sources" {
#   value = local.clean_identity_sources
# }

# output "authorizers" {
#   value = local.authorizers
# }

output "raw_data" {
  value = local.decoded_data
}

output "test_data" {
  value = local.test_data
}

# resource "aws_instance" "app_server" {
#   ami           = "ami-830c94e3"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "ExampleAppServerInstance"
#   }
# }
