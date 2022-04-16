param vmPrefix string
param AVDnumberOfInstances int
param location string = 'germanywestcentral'
param currentInstances int
param vmSize string
param administratorAccountUserName string
param administratorAccountPassword string


resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = [for i in range(0, AVDnumberOfInstances): {
  name: '${vmPrefix}-${i + currentInstances}${'nic'}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            name: 'Subnet-1'
          }
        }
      }
    ]
  }
}]

resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: '${vmPrefix}-${i + currentInstances}'
  location: location
  properties: {
    licenseType: 'Windows_Client'
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: '${vmPrefix}-${i + currentInstances}'
      adminUsername: administratorAccountUserName
      adminPassword: administratorAccountPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'Automatic'
        }
      }
    }
    storageProfile: {
      osDisk: {
        name: '${vmPrefix}-${i + currentInstances}-OS'
        managedDisk: {
          storageAccountType: 'StandardSSD_ZRS'
        }
        osType: 'Windows'
        createOption: 'FromImage'
      }
      imageReference: {
        publisher: 'microsoftwindowsdesktop'
        offer: 'office-365'
        sku: 'win10-21h2-avd-m365-g2'
        version: 'latest'
      }
      dataDisks: []
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId('Microsoft.Network/networkInterfaces', '${vmPrefix}-${i + currentInstances}${'nic'}')
        }
      ]
    }
  }
  dependsOn: [
    networkInterface
  ]
}
