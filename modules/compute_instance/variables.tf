variable "env" {
  description = "Environment name (testing/production)"
  type        = string
}

variable "machine_type" {
  description = "Type of the machine"
  type        = string
}

variable "startup_script" {
  description = "Path to the startup script"
  type        = string
}
