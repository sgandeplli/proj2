provider "google" {
  project = "primal-gear-436812-t0"
  region = "us-central1"
}

resource "google_compute_instance" "centos_vm" {
  name = "sekhar-instance"
  machine_type = "e2-medium"
  zone = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-9"  # Correct image family
    }
  }

   network_interface {
    network = "default"
    access_config {
    }
  }
/*  metadata = {
    startup-script = <<-EOT
      #!/bin/bash
      yum update -y        # Update the package manager
      yum install -y httpd # Install Apache
      systemctl start httpd # Start the Apache service
      systemctl enable httpd # Enable Apache to start on boot
    EOT
  }
*/
  metadata = {
  startup-script = <<-EOT
    #!/bin/bash
    exec > /var/log/startup-script.log 2>&1
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
  EOT
}


}
