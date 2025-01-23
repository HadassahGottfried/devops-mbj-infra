output "instance_template_self_link" {
  description = "The self-link of the instance template."
  value       = google_compute_instance_template.my_instance_template.self_link
}

output "mig_self_link" {
  description = "The self-link of the managed instance group."
  value       = google_compute_region_instance_group_manager.my_mig_with_health_check.self_link
}
