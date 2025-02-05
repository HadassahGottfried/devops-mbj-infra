output "mig_self_link" {
  description = "The self-link of the managed instance group."
  value       = google_compute_region_instance_group_manager.mig.self_link
}
