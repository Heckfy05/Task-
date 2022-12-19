# CloudLAMP Terraform infrastructure file for GCP
# Please provide your credentials and project id to create a LAMP instance on GCP  

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  credentials = file(".json") # Provide key folder destination ( Key in JSON format)

  project = "" # Specify your project id
  region  = "us-central1"
  zone    = "us-central1-c"
}
# Creating Instance
resource "google_compute_instance" "Task4" {
    name = "lamp1"
    machine_type = "e2-medium"
    tags         = ["http-server"]

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11"
      }
    }
    network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  } 
    metadata = {
     "startup-script" = <<-EOF
    sudo mkdir -p /var/www/html/
    sudo echo "<h2>LAMP created from Terraform script by Ruslan Karpyn<h2>" > /var/www/html/index.html
    sudo apt update -y
    sudo apt install -y apache2
    sudo service apache2 start
    sudo apt install mariadb-server
    sudo apt install php libapache2-mod-php php-mysql
    sudo service apache2 restart
    EOF
    }
}
