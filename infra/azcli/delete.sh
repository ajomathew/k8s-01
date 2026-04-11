# Customize these values
RESOURCE_GROUP="rg-store-ajk-dev-eastus-001"
LOCATION="eastus"
AKS_NAME="aks-store-ajk-dev-eastus-001"
ACR_NAME="acronlinestoredeveastus001"
NODE_COUNT=1

az aks delete -g $RESOURCE_GROUP -n $AKS_NAME
az acr delete -g $RESOURCE_GROUP -n $ACR_NAME
az group delete -n $RESOURCE_GROUP