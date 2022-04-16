// =========== main.bicep ===========
targetScope = 'subscription'

param vnetname string = 'vnet-core'
param hostpoolname string = 'hp-core'
param location string = 'germanywestcentral'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rgcore'
  location: location
}
