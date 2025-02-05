variable "env" {
  description = "Environment name (testing/production)"
  type        = string
}

variable "region" {
  description = "Region where resources will be created"
  type        = string
}

variable "zones" {
  description = "List of zones for the MIG"
  type        = list(string)
}

variable "instance_template_self_link" {
  description = "Self-link of the instance template"
  type        = string
}

variable "max_replicas" {
  description = "Maximum number of instances"
  type        = number
}

variable "min_replicas" {
  description = "Minimum number of instances"
  type        = number
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

