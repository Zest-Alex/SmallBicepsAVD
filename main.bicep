targetScope = 'subscription'

@description('Parameter für die Resource Gruppe')
param ResourceGroupName string = 'rgcore'
param location string = 'germanywestcentral'

@description('Parameter für Vnet')
param vnetName string = 'vnetcore'

@description('Parameter für Hostpool')
param hostPoolname string = 'HP-Core'
param maxSessionLimit int = 4
param applicationGroupName string = 'appGroupCore'
param workSpaceName string = 'WS-Core'

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
    applicationGroupName: applicationGroupName
    workSpaceName: workSpaceName
  }
  dependsOn: [
    VnetDeploy
  ]
}
