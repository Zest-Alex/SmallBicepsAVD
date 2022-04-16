param hostPoolname string = 'HP-Core'
param location string = 'germanywestcentral'
param maxSessionLimit int = 4

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

