variable "project_id" {
  description = "Project ID in GCP"
  type        = string
}

variable "region" {
  description = "Deployment region"
  type        = string
  default     = "me-west1"
}

variable "zones" {
  description = "List of zones for the instance group"
  type        = list(string)
  default     = ["me-west1-a", "me-west1-b"]
}

variable "machine_type" {
  description = "Machine type for instance"
  type        = string
  default     = "e2-medium"
}

variable "startup_script" {
  description = "Path to startup script"
  type        = string
  default     = "../startup.sh"
}

variable "min_replicas" {
  description = "Minimum number of instances in the MIG"
  type        = number
  default     = 2
}

variable "max_replicas" {
  description = "Maximum number of instances in the MIG"
  type        = number
  default     = 5
}

variable "env" {
  description = "Environment name (test/prod)"
  type        = string
  default     = "prod"
}
variable "network" {
  description = "The network where the firewall rules apply"
  type        = string
  default     = "default"
}

variable "target_tags" {
  description = "Network tags to apply firewall rules"
  type        = list(string)
  default     = ["health-check-tag"]
}

variable "ports" {
  description = "Allowed ports for health check"
  type        = list(string)
  default     = ["80", "443"]
}

variable "allow_health_check_name" {
  description = "Firewall rule name for allowing health check"
  type        = string
  default     = "allow-health-checks"
}

variable "deny_all_name" {
  description = "Firewall rule name for denying all inbound traffic"
  type        = string
  default     = "deny-all-inbound"
}


