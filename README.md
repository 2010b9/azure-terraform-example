# NOS Open Question (IaC)

> Last updated: 2024-01-19

## Setup the infrasturcture

If you don't yet have a storage account that serves as backend to store your terraform state files, run `sh create_storage_account.sh` to create a it. Define the `RESOURCE_GROUP_NAME`, `STORAGE_ACCOUNT_NAME` and `CONTAINER_NAME` .

Then `cd` to `environments/development` and run
```bash
terraform init
terraform plan
terraform apply
```

This will create your infrastructure if you haven't already.
