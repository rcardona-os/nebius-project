resource "nebius_mk8s_v1_cluster" "k8s-cluster" {
  parent_id = var.parent_id
  name      = join("-", ["k8s-training", local.release-suffix])
  control_plane = {
    endpoints = {
      public_endpoint = {}
    }
#    etcd_cluster_size = var.etcd_cluster_size
    subnet_id         = var.subnet_id
    version           = var.k8s_version
  }
}

resource "nebius_mk8s_v1_node_group" "cpu-only" {
  fixed_node_count = var.cpu_nodes_count
  parent_id        = nebius_mk8s_v1_cluster.k8s-cluster.id
  name             = join("-", ["k8s-ng-cpu", local.release-suffix])
  labels = {
    "library-solution" : "k8s-training",
  }
  version = var.k8s_version
  template = {
    boot_disk = {
      size_gibibytes = var.cpu_disk_size
      type           = var.cpu_disk_type
    }

    service_account_id = var.enable_k8s_node_group_sa ? nebius_iam_v1_service_account.k8s_node_group_sa[0].id : null

    network_interfaces = [
      {
        public_ip_address = {}
        subnet_id         = var.subnet_id
      }
    ]
    resources = {
      platform = local.cpu_nodes_platform
      preset   = local.cpu_nodes_preset
    }
    filesystems = var.enable_filestore ? [
      {
        attach_mode         = "READ_WRITE"
        mount_tag           = "data"
        existing_filesystem = nebius_compute_v1_filesystem.shared-filesystem[0]
      }
    ] : null
    underlay_required = false
    cloud_init_user_data = templatefile("../modules/cloud-init/k8s-cloud-init.tftpl", {
      enable_filestore = var.enable_filestore ? "true" : "false",
      enable_glusterfs = var.enable_glusterfs ? "true" : "false",
      glusterfs_host   = var.enable_glusterfs ? module.glusterfs[0].glusterfs-host : "",
      glusterfs_volume = var.enable_glusterfs ? module.glusterfs[0].volume : "",
      ssh_user_name    = var.ssh_user_name,
      ssh_public_key   = local.ssh_public_key
    })
  }
}

resource "nebius_mk8s_v1_node_group" "gpu" {
  fixed_node_count = var.gpu_nodes_count
  parent_id        = nebius_mk8s_v1_cluster.k8s-cluster.id
  name             = join("-", ["k8s-ng-gpu", local.release-suffix])
  labels = {
    "library-solution" : "k8s-training",
  }
  version = var.k8s_version
  template = {
    metadata = {
      labels = var.mig_parted_config != null ? {
        "nvidia.com/mig.config" = var.mig_parted_config
      } : {}
    }

    boot_disk = {
      size_gibibytes = var.gpu_disk_size
      type           = var.gpu_disk_type
    }

    service_account_id = var.enable_k8s_node_group_sa ? nebius_iam_v1_service_account.k8s_node_group_sa[0].id : null

    network_interfaces = [
      {
        subnet_id         = var.subnet_id
        public_ip_address = var.gpu_nodes_assign_public_ip ? {} : null
      }
    ]
    resources = {
      platform = local.gpu_nodes_platform
      preset   = local.gpu_nodes_preset
    }
    filesystems = var.enable_filestore ? [
      {
        attach_mode         = "READ_WRITE"
        mount_tag           = "data"
      }
    ] : null
    gpu_cluster       = nebius_compute_v1_gpu_cluster.fabric_2
    underlay_required = false
    cloud_init_user_data = templatefile("../modules/cloud-init/k8s-cloud-init.tftpl", {
      ssh_user_name    = var.ssh_user_name,
      ssh_public_key   = local.ssh_public_key
    })
  }
}

the lkdjljiompmvlk =cdcdhcdjknhiujloiojsspcmsojvoosdffossdsd
i 0 r+r.
