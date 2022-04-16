param hostPoolname string = 'HP-Core'
param location string = 'germanywestcentral'
param maxSessionLimit int = 4
param applicationGroupName string = 'appGroupCore'
param workSpaceName string = 'WS-Core'

resource hostpooldeploy 'Microsoft.DesktopVirtualization/hostPools@2022-02-10-preview' = {
  name: hostPoolname
  location: location
  properties: {
    customRdpProperty: 'targetisaadjoined:i:1'
    hostPoolType: 'Pooled'
    loadBalancerType: 'BreadthFirst'
    maxSessionLimit: maxSessionLimit
    personalDesktopAssignmentType: 'Automatic'
    preferredAppGroupType: 'Desktop'
    publicNetworkAccess: 'Enabled'
  }
}

resource applicationGroup 'Microsoft.DesktopVirtualization/applicationGroups@2022-02-10-preview' = {
  name: applicationGroupName
  location: location
  properties: {
    applicationGroupType: 'Desktop'
    hostPoolArmPath: resourceId('Microsoft.DesktopVirtualization/hostpools', hostPoolname)
  }
  dependsOn: [
    hostpooldeploy
  ]
}

resource workSpace 'Microsoft.DesktopVirtualization/workspaces@2022-02-10-preview' = {
  name: workSpaceName
  location: location
  properties: {
  }
  dependsOn: [
    applicationGroup
  ]
}
