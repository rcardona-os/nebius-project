resource "nebius_compute_v1alpha1_disk" "boot_disk" {
  name                 = var.boot_disk.name
  type                 = var.boot_disk.type
  size_gibibytes       = var.boot_disk.size_gibibytes
  source_image_family  = var.boot_disk.source_image_family
  block_size_bytes     = var.boot_disk.block_size_bytes
  parent_id            = var.parent_id
}