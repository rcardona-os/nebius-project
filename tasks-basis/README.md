## Provision simple vm

#### 1 - Create a boot disk
```bash
$ export BOOT_DISK_ID=$(nebius compute disk create \
  --name disk-ubuntu-os \
  --size-gibibytes 100 \
  --type network_ssd \
  --source-image-family-image-family ubuntu22.04-cuda12 \
  --block-size-bytes 4096 \
  --format json \
  | jq -r ".metadata.id")
```

#### 2 - Get subnet infroamtion
```bash
$ export SUBNET_ID=$(nebius vpc subnet list \
  --format json | jq -r ".items[0].metadata.id")
```

#### 3 - Create user data configuration
```bash
$ export USER_DATA_JSON=$(cat <<EOF | tee user-data.yaml | jq -Rs
#cloud-config
users:
  - name: raf
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2E....
EOF
)
```

#### 4 - Provision VM
```bash
$ export PLATFORM_ID="cpu-d3"
$ export PRESET_NAME="4vcpu-16gb"
```

```bash
$ nb compute instance create ${GPU_CLUSTER_ID:+--gpu-cluster-id "$GPU_CLUSTER_ID"} - <<EOF
{
  "metadata": {
    "name": "first-vm"
  },
  "spec": {
    "stopped": false,
    "cloud_init_user_data": $USER_DATA_JSON,
    "resources": {
      "platform": "$PLATFORM_ID",
      "preset": "$PRESET_NAME"
    },
    "boot_disk": {
      "attach_mode": "READ_WRITE",
      "existing_disk": {
        "id": "$BOOT_DISK_ID"
      }
    },
    "network_interfaces": [
      {
        "name": "network-interface-0",
        "subnet_id": "$SUBNET_ID",
        "ip_address": {},
        "public_ip_address": {}
      }
    ]
  }
}
EOF
```

#### Listing all vms
```bash
$ nb compute instance list --format json | jq -r '
  .items[] 
  | [
      .metadata.name, 
      .metadata.id,
      .status.network_interfaces[0].ip_address.address, 
      .status.network_interfaces[0].public_ip_address.address, 
      .status.state
    ] 
  | @tsv'
```

#### Listing running vms
```bash
$ nb compute instance list --format json | jq -r '
  .items[] 
  | select(.status.state == "RUNNING") 
  | [
      .metadata.name, 
      .metadata.id,
      .status.network_interfaces[0].ip_address.address, 
      .status.network_interfaces[0].public_ip_address.address, 
      .status.state
    ] 
  | @tsv'
```

#### Deleting vms
```bash
$ nb compute instance delete --id <your-instance-id>
```