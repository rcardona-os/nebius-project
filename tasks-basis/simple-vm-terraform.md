#### Folder structure

simple-vm-terraform/

├── 0-provider.tf

├── 1-boot-disk.tf

├── 2-vm-provision.tf.hold

├── terraform.tfvars

├── outputs.tf

├── user-data.yaml


#### 1 - Prerequisites

- [Service account](https://github.com/rcardona-os/nebius-project/tree/main?tab=readme-ov-file#create-service-account) associated with the editors group of the project

#### 2 - Create an authorized key
```bash
$ mkdir -p ~/.nebius/authkey
```
```bash
$ export NB_AUTHKEY_PRIVATE_PATH=~/.nebius/authkey/private.pem
```
```bash
$ export NB_AUTHKEY_PUBLIC_PATH=~/.nebius/authkey/public.pem
```
```bash
$ openssl genrsa -out $NB_AUTHKEY_PRIVATE_PATH 4096
```
```bash
$ openssl rsa -in $NB_AUTHKEY_PRIVATE_PATH \
  -outform PEM -pubout -out $NB_AUTHKEY_PUBLIC_PATH
```

#### 3 - Upload a public key to create the authorized key and save its ID
```bash
$ export NB_AUTHKEY_PUBLIC_ID=$(nebius iam auth-public-key create \
 --account-service-account-id $NB_SA_ID \
 --data "$(cat $NB_AUTHKEY_PUBLIC_PATH)" \
 --format json | jq -r '.metadata.id')
```

#### 4 - Initialise terraform
```bash
$ terraform init
```

