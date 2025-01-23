# Configure the Google Cloud provider
provider "google" {
  
  credentials = file("./terraform-hadassah-gottfried-bc8c541ff75f.json")
  project     = var.project_id
  region      = var.region
}

# Instance Template
resource "google_compute_instance_template" "my_instance_template" {
  name         = "myname-instance-template"
  machine_type = var.machine_type

  disk {
    auto_delete = true
    boot        = true
    source_image = "projects/debian-cloud/global/images/family/debian-12"
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = file(var.startup_script)
}

# Health Check
resource "google_compute_region_health_check" "my_health_check" {
  name     = "myname-health-check"
  region   = var.region
  check_interval_sec = 10
  timeout_sec        = 5

  http_health_check {
    port = 80
  }
}

resource "google_compute_region_instance_group_manager" "my_mig_with_health_check" {
  name                = "myname-mig"
  region              = var.region
  base_instance_name  = var.base_instance_name
  target_size         = 1

  version {
    instance_template = google_compute_instance_template.my_instance_template.self_link
    name              = "version-1"
  }

  update_policy {
    type                          = "PROACTIVE"
    minimal_action                = "RESTART"
    instance_redistribution_type  = "PROACTIVE"
  }

  auto_healing_policies {
    health_check      = google_compute_region_health_check.my_health_check.self_link
    initial_delay_sec = 300
  }

  depends_on = [
    google_compute_instance_template.my_instance_template,
    google_compute_region_health_check.my_health_check
  ]
}




# AutoScaler
resource "google_compute_region_autoscaler" "my_autoscaler" {
  name   = "myname-autoscaler"
  region = var.region

  target = google_compute_region_instance_group_manager.my_mig_with_health_check.self_link

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 60
    cpu_utilization {
      target = 0.6
    }
  }
}
