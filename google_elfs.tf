variable "DISKTYPE"{
  default = "local"
}
variable "NUM_OF_VMS"{
  default = "3"
}
variable "NUM_OF_DISKS"{
  default = "1"
}
variable "CLUSTER_NAME"{
}
variable "IMAGE"{
}
variable "SETUP_COMPLETE"{
  default = "false"
}
variable "PASSWORD_IS_CHANGED"{
  default = "false"
}
variable "PASSWORD"{
  default = "changeme"
}
variable "ZONE"{
  default = "us-central1-a"
}
variable "PROJECT"{
  default = "elastifile-sa"
}

provider "google" {
//  credentials = "${file("andrew-sa-elastifile-sa.json")}"
  project     = "${var.PROJECT}"
  region      = "${var.ZONE}"
}

resource "google_compute_instance" "andrew-elcc" {
  name         = "${var.CLUSTER_NAME}"
  machine_type = "n1-highcpu-16"
  zone         = "${var.ZONE}"

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7-v20171129"
    }
  }

  scratch_disk {
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  // scheduling {
  //   preemptible = true
  // }

  metadata {
    reference_name = "${var.CLUSTER_NAME}"
    password_is_changed = "${var.PASSWORD_IS_CHANGED}"
    setup_complete = "${var.SETUP_COMPLETE}"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["cloud-platform"]
  }

  provisioner "file" {
      source = "configure_elcc.sh"
      destination = "configure_elcc.sh"
      connection {
        type = "ssh"
        user = "andrew"
        private_key = "${file("~/.ssh/google_compute_engine")}"
      }
  }

  provisioner "file" {
      source = "createfiles.sh"
      destination = "createfiles.sh"
      connection {
        type = "ssh"
        user = "andrew"
        private_key = "${file("~/.ssh/google_compute_engine")}"
      }
  }

  provisioner "file" {
      source = "runcc.sh"
      destination = "runcc.sh"
      connection {
        type = "ssh"
        user = "andrew"
        private_key = "${file("~/.ssh/google_compute_engine")}"
      }
  }

  provisioner "file" {
      source = "../andrew-sa-elastifile-sa.json"
      destination = "andrew-sa-elastifile-sa.json"
      connection {
        type = "ssh"
        user = "andrew"
        private_key = "${file("~/.ssh/google_compute_engine")}"
      }
  }

  provisioner "remote-exec" {
      inline = [
        "sudo yum install -y java","sudo yum install -y nano","curl -O https://storage.googleapis.com/elastifile-upgrade-files/${var.IMAGE}", "tar -xvf ${var.IMAGE}", "sudo ./elcc*/install.sh", "sudo systemctl start ccweb" , "sudo chmod a+x *.sh"
      ]
      connection {
        type = "ssh"
        user = "andrew"
        private_key = "${file("~/.ssh/google_compute_engine")}"
      }
    }
}
