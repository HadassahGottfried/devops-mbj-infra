provider "google" {
  credentials = file("C:/Users/hadas/devops-mbj-infra/service-account-key.json") # נתיב יחסי
  project     = var.project_id
  region      = var.region
}
module "compute_instance" {
  source         = "../modules/compute_instance"
  env            = var.env
  machine_type   = var.machine_type
  startup_script = var.startup_script
}

module "mig_autoscaler" {
  source                     = "../modules/mig_autoscaler"
  env                        = var.env
  region                     = var.region
  zones                      = var.zones
  instance_template_self_link = module.compute_instance.instance_template_self_link
  max_replicas               = var.max_replicas
  min_replicas               = var.min_replicas
  target_tags             = ["health-check-tag"]
  allow_health_check_name = "${var.env}allow-health-checks"
  deny_all_name           = "${var.env}deny-all-inbound"
  ports                   = ["80", "443"]
}
