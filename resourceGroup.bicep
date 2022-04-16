targetScope = 'subscription'

param ResourceGroupName string = 'rgcore'
param location string = 'germanywestcentral'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: ResourceGroupName
  location: location
}
