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
  --name editors --parent-id <tenant_id> --format json \
  | jq -r '.metadata.id')
```

