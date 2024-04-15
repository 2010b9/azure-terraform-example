# Example IaC for Azure with `terraform`

> Last updated: 2024-04-15

## Introduction

This is a simple repo showcasing how to setup some simple infrastructure in Azure. Namely,
- a `Resource Group` with a `Storage Account`. This is created using the `create_storage_account.sh` bash script and is intended to be used before using terraform. The `Resource Group` will have all the resources the project might need (each environment – `development`, `production`, etc. should have its own `Resource Group`) and the `Storage Account` will store the `tfstate`, which is a file that holds the state of the infrastucture `terraform` built. Each time a new service is added or a current service is altered/deleted, the `tfstate` will be checked to see which infrastructure to change/delete and will update that file accordingly with the changes made.
- a `Container Registry`, which is used to store Docker Images (this can be the image of an app we are building, for example.). Ideally, this service should be accessed via GitHub Actions (or any other CI/CD provider) and a new version of the image should be added to the registry.
- a `Container Instance`, which is a service used to run a container. This can be used to run the images stored in the `Container Registry` or can directly access the [`Docker Hub`](https://hub.docker.com/), so that you only need to specify the image and the tag that you wish to use. For example, you may run a `postgresql` container and use this for your development database (which should probably be less expensive than instantiating a DB service).
- a `Web App` can be used to host a web application. It can, for example, access you `Container Registry` and spin a container with the image you want. You can also deploy, for example, Python code to this service via CI/CD from your repo if you are using Flask/FastAPI. I prefer to use Docker Images, since I've ran into some problems using code deployments (but for simple apps should be enough!).

## Repo Structure

The repo has the following structure.

```bash
.
├── README.md
├── create_storage_account.sh
├── environments
│   ├── development
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   └── variables.tf
│   └── production
└── modules
    ├── aci
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── acr
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── app-service
    │   ├── main.tf
    │   └── variables.tf
    └── sql-db
        ├── main.tf
        └── variables.tf
```

In the `modules` folder we have several services that we can instantiate. They are reusable and we can change any configurations (CPU, RAM, ports, etc.) that we need to make them more suitable to different environments (`development`, `stage`, `production`, etc.). Each of subfolders inside `modules` corresponds to a different service.

The `environments` folder is divided into several environments (for now just `production` and `development`) and makes use of the modules in the `modules` folder to instantiate the infrastructure with the necessary configurations.

## How to use?

If you don't yet have a storage account that serves as backend to store your terraform state files, run `sh create_storage_account.sh` to create a it. Define the `RESOURCE_GROUP_NAME`, `STORAGE_ACCOUNT_NAME` and `CONTAINER_NAME` .

Then `cd` to `environments/development` and run
```bash
terraform init
terraform plan
terraform apply
```

This will create your infrastructure if you haven't already.
