



provider "google" {
  project     = var.project
  credentials = file(var.credentials_file)
  region      = var.region
  zone        = var.zone
}


resource "google_compute_instance" "my_instance" {
  name                      = "terraform-instance"
  machine_type              = var.vm_params[0]
  zone                      = var.vm_params[1]
  allow_stopping_for_update = var.vm_params[2]

  boot_disk {
    initialize_params {
    #   image = "debian-cloud/debian-11"
      image = var.instance_image
      size  = var.instance_size
      type  = var.instance_type
    }

  }

  network_interface {
    network = "default"
    # network = google_compute_network.terraform_network.self_link
    # subnetwork = google_compute_subnetwork.terraform_subnet.self_link
    access_config {

    }
  }
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "allow-rdp"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["rdp-access"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"] 
  target_tags   = ["ssh-access"]
}

# resource "google_compute_network" "terraform_network" {

#     name = "terraform_network"
#     auto_create_subnetworks = false
  
# }

# resource "google_compute_subnetwork" "terraform_subnet" {
#   name = "terraform_subnet"
#   ip_cidr_range = "10.20.0.0/16"
#   region = "asia-south1"
#   network = google_compute_network.terraform_network.id
# }