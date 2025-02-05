project_id = "terraform-hadassah-gottfried"
region     = "me-west1"
zones      = ["me-west1-a", "me-west1-b"]
machine_type = "e2-medium"
startup_script = "../startup_script.sh"
min_replicas = 2
max_replicas = 5
env = "prod"
