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
}

locals {
  decoded_data = jsondecode(base64decode(var.base64_data))

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

# resource "aws_instance" "app_server" {
#   ami           = "ami-830c94e3"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "ExampleAppServerInstance"
#   }
# }
