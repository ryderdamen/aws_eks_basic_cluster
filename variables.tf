variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "environment" {
  type        = string
  description = "The environment of the cluster"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "A list of public subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of private subnet IDs"
}
