targetScope = 'subscription'

@description('Parameter für die Resource Gruppe')
param ResourceGroupName string = 'rgcore'
param location string = 'germanywestcentral'

@description('Parameter für Vnet')
param vnetName string = 'vnetcore'

@description('parameter für Hostpool')
param hostPoolname string = 'HP-Core'
param maxSessionLimit int = 4


module ResourceGroupCreate './resourceGroup.bicep' = {
  name: 'resourceGroupDeploy'
  params: {
    ResourceGroupName: ResourceGroupName
    location: location
  }
  
}

module VnetDeploy './vnet.bicep' = {
  name: 'VnetDeploy'
  scope: resourceGroup(ResourceGroupName)
  params: {
    vnetName: vnetName
    location: location
  }
  dependsOn: [
    ResourceGroupCreate
  ]
}

module hostpoolcreate './hostpool.bicep' = {
  name: 'hostpoolDeploy'
  scope: resourceGroup(ResourceGroupName)
  params: {
    hostPoolname: hostPoolname
    maxSessionLimit: maxSessionLimit
    location: location
  }
  dependsOn: [
    VnetDeploy
  ]
}
