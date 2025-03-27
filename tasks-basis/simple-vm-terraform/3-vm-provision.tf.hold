resource "nebius_compute_instance" "vm" {
  name        = "my-vm"
  platform_id = "standard-v1"
  zone_id     = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    user-data = filebase64("${path.module}/user-data.yaml")
  }
}