## Provision simple vm

#### 1 - Find compute platform_id for the selected preset (i.e cpu-d3, 4vcpu-16gb)
```bash
$ export PLATFORM_ID=$(nb compute platform list --format json | jq -r '
  .items[] | select(.metadata.name == "cpu-d3") | .metadata.id')
```

```bash
$ export PRESET_NAME="4vcpu-16gb"
```

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

#### 3 - Create a user data configuration
```bash
$ export USER_DATA=$(jq -Rs '.' <<EOF
users:
  - name: $USER
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - $(cat ~/.ssh/id_rsa.pub)
EOF
)
```

#### 2 - Provision VM
```bash
$ nb compute instance create \
  ${GPU_CLUSTER_ID:+--gpu-cluster-id} ${GPU_CLUSTER_ID:+"$GPU_CLUSTER_ID"} \
  - <<EOF
{
  "metadata": {
    "name": "first-vm"
  },
  "spec": {
    "stopped": false,
    "cloud_init_user_data": $USER_DATA,
    "resources": {
      "platform": $PLATFORM_ID,
      "preset": $PRESET_NAME
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