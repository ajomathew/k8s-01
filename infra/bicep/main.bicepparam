using 'main.bicep'

param projectName =  'ajk'
param environment =  'dev'
param location = 'eastus'
param resourceInstance = '001'
param agentVMSize = 'Standard_B2s'
// Network
param vnetAddressPrefix = '10.0.0.0/16'
param subnets = [
  {
    name: 'privateEndpoints'
    addressPrefix: '10.0.0.0/24'
  }
  {
    name: 'snet-agents'
    addressPrefix: '10.0.1.0/24'
  }
]
