output "public_ip" {
  value = nebius_compute_instance.vm.network_interface[0].nat_ip_address
}