#!/bin/bash
# Passed validation in Cloud Shell on 3/2/2022

# Create secure five node Linux cluster. Creates a key vault in a resource group
# and creates a certficate in the key vault. The certificate's subject name must match 
# the domain that you use to access the Service Fabric cluster.  The certificate is downloaded locally.


# Variable block for creating cluster with service fabric
let "randomIdentifier=$RANDOM*$RANDOM"
location="East US"
resourceGroup="msdocs-service-fabric-rg-$randomIdentifier"
tags="create cluster"
cluster="msdocs-cluster-$randomIdentifier"
os="UbuntuServer1604"
clusterSize="5"
password="Pa$$w0rD-$randomIdentifier"
subject="aztestcluster.eastus.cloudapp.azure.com" 
vault="msdocs-keyvault-$randomIdentifier" 
vmPassword="Pa$$w0rD-vm-$randomIdentifier"
vmUser="azureuser"

# Create a resource group
echo "Creating $resourceGroup in "$location"..."
az group create --name $resourceGroup --location "$location" --tag $tag

# Create service fabric cluster
echo "Creating $cluster" with $vault
az sf cluster create --resource-group $resourceGroup --location "$location" \
  --certificate-output-folder . --certificate-password $password --certificate-subject-name $subject \
  --cluster-name $cluster --cluster-size $clusterSize --os $os --vault-name $vault \
  --vault-rg $resourceGroup --vm-password $vmPassword --vm-user-name $vmUser
  
# echo "Deleting all resources"
# az group delete --name $resourceGroup -y
  