#### Folder structure

simple-vm-terraform/

├── main.tf

├── variables.tf

├── terraform.tfvars

├── outputs.tf

├── user-data.yaml


#### 1 - Create service account
- Creating service account
```bash
$ export NB_SA_ID=$(nb iam service-account create \
  --name terraform-sa --format json \
  | jq -r '.metadata.id')
```

- Getting *editors* ID
```bash
$ export NB_EDITORS_GROUP_ID=$(nebius iam group get-by-name \
  --name editors --parent-id < tenant_id > --format json \
  | jq -r '.metadata.id')
```

- Associating the service account to the *editors* group
```bash
$ nb iam group-membership create \
  --parent-id $NB_EDITORS_GROUP_ID \
  --member-id $NB_SA_ID
```

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
