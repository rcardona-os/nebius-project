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

#### 2 - Create user data
```bash
$ cat user-data.yaml
```

```bash
$ export USER_DATA_JSON=$(jq -Rs < user-data.yaml)
```

#### 3- Provision VM
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


#### Listing running vms
```bash
$ nb compute instance list --format json | jq -r '
  .items[] 
  | select(.status.state == "RUNNING") 
  | [
      .metadata.name, 
      .status.network_interfaces[0].ip_address.address, 
      .status.network_interfaces[0].public_ip_address.address, 
      .status.state
    ] 
  | @tsv'
```