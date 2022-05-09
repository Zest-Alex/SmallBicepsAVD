targetScope = 'resourceGroup'
param ResourceGroupName string


@description('Parameter für Vnet')
param vnetName string
param location string

@description('Parameter für Hostpool')
param hostPoolname string
param maxSessionLimit int
param applicationGroupName string
param workSpaceName string

module VnetDeploy './vnet.bicep' = {
  name: 'VnetDeploy'
  scope: resourceGroup(ResourceGroupName)
  params: {
    vnetName: vnetName
    location: location
  }
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
