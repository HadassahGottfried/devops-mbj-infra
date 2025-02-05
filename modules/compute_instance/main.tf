resource "google_compute_instance_template" "instance_template" {
  name         = "${var.env}-hadassah-instance-template"
  machine_type = var.machine_type
  tags         = ["health-check-tag"]

  disk {
    auto_delete  = true
    boot         = true
    source_image = "projects/debian-cloud/global/images/family/debian-12"
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = file(var.startup_script)
}
