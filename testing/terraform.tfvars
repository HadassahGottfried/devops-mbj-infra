project_id = "terraform-hadassah-gottfried"
region     = "me-west1"
zones      = ["me-west1-a", "me-west1-b"]
machine_type = "e2-micro"
startup_script = "../startup_script.sh"
min_replicas = 1
max_replicas = 3
env = "test"
