resource "nebius_compute_v1alpha1_disk" "boot_disk" {
  name                 = var.boot_disk_name
  type                 = var.boot_disk_type
  size_gibibytes       = var.boot_disk_size_gibibytes
  source_image_family  = var.boot_disk_source_image_family
  block_size_bytes     = var.boot_disk_block_size_bytes
  parent_id            = var.parent_id
}