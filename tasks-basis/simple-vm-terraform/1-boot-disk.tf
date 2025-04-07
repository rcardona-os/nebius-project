resource "nebius_compute_v1_disk" "boot_disk" {
  name     = "my-boot-disk"
  zone_id  = "ru-central1-a"
  type_id  = "network-hdd"
  size     = 50
  image_id = var.image_id
  parent_id = "PARENT_ID"
  type = 
}
