#!/bin/bash

# This script should be used to create a storage account to serve as the terraform
# backend and store the state files. Most of this script was based on the following URL
# https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli
RESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstate
CONTAINER_NAME=tfstate

# Login to Azure CLI
az login && echo "==> Logged in"

# Create resource group
az group create \
    --name $RESOURCE_GROUP_NAME \
    --location westeurope \
    && echo "==> Resource group created"

# Create storage account
az storage account create \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $STORAGE_ACCOUNT_NAME \
    --sku Standard_LRS \
    --encryption-services blob \
    --min-tls-version TLS1_2 \
    && echo "==> Storage account created"

# Create blob container
az storage container create \
    --name $CONTAINER_NAME \
    --account-name $STORAGE_ACCOUNT_NAME \
    && echo "==> Storage container created"
