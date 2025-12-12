variable "ecr_name" {
  description = "name foraws elastic container registry"
  type = string
}

variable "region_name" {
  description = "provider region name"
  type = string
}

variable "image_tag_mutability" {
  description = "define image tag mutability of ecr repo"
  type = string
}