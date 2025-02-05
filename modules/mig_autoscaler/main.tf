resource "google_compute_region_health_check" "health_check" {
  name     = "${var.env}-hadassah-health-check"
  region   = var.region
  check_interval_sec = 10
  timeout_sec        = 5

  http_health_check {
    port = 80
  }
}

resource "google_compute_region_instance_group_manager" "mig" {
  name                = "${var.env}-hadassah-mig"
  base_instance_name  = "${var.env}-hadassah-instance"
  region              = var.region

  distribution_policy_zones = var.zones

  version {
    instance_template = var.instance_template_self_link
    name              = "version-1"
  }

  auto_healing_policies {
    health_check      = google_compute_region_health_check.health_check.self_link
    initial_delay_sec = 300
  }
}

resource "google_compute_region_autoscaler" "autoscaler" {
  name   = "${var.env}-hadassah-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.mig.self_link

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = 60
    cpu_utilization {
      target = 0.6
    }
  }
}
# חוק 1: לאפשר רק ל-Health Check גישה
resource "google_compute_firewall" "allow_health_check" {
  name    = var.allow_health_check_name
  network = var.network

  target_tags = var.target_tags

  allow {
    protocol = "tcp"
    ports    = var.ports
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]  # כתובות IP של ה-Health Checks של Google
}

# חוק 2: חסימה של כל שאר התעבורה הנכנסת (אם לא אושרה במפורש)
resource "google_compute_firewall" "deny_all_inbound" {
  name    = var.deny_all_name
  network = var.network

  target_tags = var.target_tags

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]  # כל כתובת IP בעולם (מונע גישה חיצונית)
  priority      = 65535           # עדיפות נמוכה כדי שכל חוק אחר יפעל קודם
}
