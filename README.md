# Deploying microservice applications in AKS using (AzCLI + Docker Desktop + kubectl) 

    Part1:   Manual Deployment (AzCLI + Docker Desktop + kubectl)  
    GitHub:  https://github.com/santosh-gh/k8s-01
    YouTube: https://youtu.be/zoJ7MMPVqFY

    Part2:   Automated Deployment (AzCLI + Docker + kubect + Azure Pipeline)
    GitHub:  https://github.com/santosh-gh/k8s-02
    YouTube: https://youtu.be/nnomaZVHg9I

    Part3:   Automated Infra Deployment (Bicep + Azure Pipeline)
    GitHub:  https://github.com/santosh-gh/k8s-03
    YouTube: https://www.youtube.com/watch?v=5PAdDPHn8F8

    Part4:   Manual Deployment (AzCLI + Docker Desktop + Helm charts + kubectl) 
    GitHub:  https://github.com/santosh-gh/k8s-04
    YouTube: https://www.youtube.com/watch?v=VAiR3sNavh0

    Part5:   Automated Deployment (AzCLI + Docker + Helm charts + kubectl + Azure Pipeline) 
    GitHub:  https://github.com/santosh-gh/k8s-04
    YouTube: https://www.youtube.com/watch?v=MnWe2KGRrxg&t=883s

    Part6:   Automated Deployment (AzCLI + Docker + Helm charts + kubectl + Azure Pipeline) 
             Dynamically update the image tag in values.yaml
    GitHub:  https://github.com/santosh-gh/k8s-06
    YouTube: https://www.youtube.com/watch?v=Nx0defm8T6g&t=11s

    Part7:   Automated Deployment (AzCLI + Docker + Helm charts + kubectl + Azure Pipeline)
             Store the helm chart in ACR
             Dynamically update the image tag in values.yaml
             Dynamically update the Chart version in Chart.yaml

    GitHub:  https://github.com/santosh-gh/k8s-07
    YouTube: https://www.youtube.com/watch?v=Y3RaxSZNTaU&t=1s

    Part8:   Automated Deployment (AzCLI + Docker + Helm charts + kubectl + Azure Pipeline)
             Store the helm chart in ACR
             Dynamically update the image tag in values.yaml
             Dynamically update the Chart version in Chart.yaml
             Deploy into multiple environments (dev, test, prod) with approval gates

    GitHub:  https://github.com/santosh-gh/k8s-08
    YouTube: https://www.youtube.com/watch?v=oNysAAGijGk&t=43s

    Part9:   Manual Deployment (AzCLI + Docker + kustomize + kubectl)          
             Deploy into multiple environments (dev, test, prod) through command line

    GitHub:  https://github.com/santosh-gh/k8s-09
    YouTube: https://www.youtube.com/watch?v=Jtz1KldOPAA&t=1s

    Part10:  Automated Deployment (AzCLI + Docker + kustomize + kubectl + Azure Pipeline)          
             Deploy into multiple environments (dev, test, prod) through automated pipeline

    GitHub:  https://github.com/santosh-gh/k8s-10
    YouTube: https://www.youtube.com/watch?v=VAiR3sNavh0

# Architesture

![Store Architesture](aks-store-architecture.png)

    # Store front: Web application for customers to view products and place orders.
    # Product service: Shows product information.
    # Order service: Places orders.
    # RabbitMQ: Message queue for an order queue.

# Directory Structure

![Directory Structure](image.png) 

# Deploying microservice applications in AKS using 

    Infra deploy: using command line AzCLI

    Docker build and push images to ACR: Docker Desktop command line

    App Deploymnet: kubectl command

# Steps

    1. Infra deployment using AzCLI
    2. Build and push images to ACR: Docker
    3. Deploy using kubectl
    5. Validate and Access the application
    6. Clean the Azure resources

# Infra deployment
```bash
    # Login to Azure

        az login
        az account set --subscription=<subscriptionId>
        az account show

    # Show existing resources

        az resource list

    # Create RG, ACR and AKS

        # AzCLI
        ./infra/azcli/script.sh

    # Connect to cluster

        RESOURCE_GROUP="rg-store-ajk-dev-eastus-001"
        AKS_NAME="aks-store-ajk-dev-eastus-001"
        az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_NAME

    # Short name for kubectl

    # Show all existing objects

        k get all
```
# Docker Build and Push
```bash
    # Log in to ACR
        ACR_NAME="acronlinestoredeveastus001"
        # az acr login --name $ACR_NAME
        az acr credential show --name $ACR_NAME
        podman login --username $ACR_NAME --password  $(az acr credential show --name $ACR_NAME --query passwords[0].value) $ACR_NAME.azurecr.io

    # Build and push the Docker images to ACR

        # Order Service
        docker build -t order ./app/order-service 
        docker tag order:latest $ACR_NAME.azurecr.io/order:v1
        docker push $ACR_NAME.azurecr.io/order:v1

        # Product Service
        docker build -t product ./app/product-service 
        docker tag product:latest $ACR_NAME.azurecr.io/product:v1
        docker push $ACR_NAME.azurecr.io/product:v1

        # Store Front Service
        docker build -t store-front ./app/store-front 
        docker tag store-front:latest $ACR_NAME.azurecr.io/store-front:v1
        docker push $ACR_NAME.azurecr.io/store-front:v1

        docker images

# Verify the Deployment

    k get pods
    k get services
    curl <LoadBalancer public IP>:80
    Browse the app using http://<LoadBalancer public IP>:80

# Clean the Azure resources

    az group delete --name rg-store-ajk-dev-eastus-001 --yes --no-wait

```