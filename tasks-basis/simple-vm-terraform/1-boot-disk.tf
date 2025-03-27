resource "nebius_compute_disk" "boot_disk" {
  name     = "my-boot-disk"
  zone_id  = "ru-central1-a"
  type_id  = "network-hdd"
  size     = 10
  image_id = var.image_id
}