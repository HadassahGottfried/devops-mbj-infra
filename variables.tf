variable "project_id" {
  description = "The ID of the Google Cloud project."
  type        = string
}

variable "region" {
  description = "The region to deploy the resources in."
  type        = string
  default     = "me-west1"
}

variable "machine_type" {
  description = "The type of machine to use for the instance template."
  type        = string
  default     = "e2-micro"
}

variable "base_instance_name" {
  description = "Base name for the instances in the MIG."
  type        = string
  default     = "hadassah-instance"
}

variable "startup_script" {
  description = "Path to the startup script file."
  type        = string
  default     = "./startup.sh"
}
variable "zones" {
  type    = list(string)
  default = ["me-west1-a", "me-west1-b"] # עדכן את האזורים
}

