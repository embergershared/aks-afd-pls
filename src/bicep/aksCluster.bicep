// Parameters
@description('Specifies the name of the AKS cluster.')
param name string = 'aks-${uniqueString(resourceGroup().id)}'

@description('Specifies whether to enable API server VNET integration for the cluster or not.')
param enableVnetIntegration bool = true

@description('Specifies the name of the existing virtual network.')
param virtualNetworkName string

@description('Specifies the name of the subnet hosting the worker nodes of the default system agent pool of the AKS cluster.')
param systemAgentPoolSubnetName string = 'SystemSubnet'

@description('Specifies the name of the subnet hosting the worker nodes of the user agent pool of the AKS cluster.')
param userAgentPoolSubnetName string = 'UserSubnet'

@description('Specifies the name of the subnet hosting the pods running in the AKS cluster.')
param podSubnetName string = 'PodSubnet'

@description('Specifies the name of the subnet delegated to the API server when configuring the AKS cluster to use API server VNET integration.')
param apiServerSubnetName string = 'ApiServerSubnet'

@description('Specifies the name of the AKS user-defined managed identity.')
param managedIdentityName string

@description('Specifies the DNS prefix specified when creating the managed cluster.')
param dnsPrefix string = name

@description('Specifies the network plugin used for building Kubernetes network. - azure or kubenet.')
@allowed([
  'azure'
  'kubenet'
])
param networkPlugin string = 'azure'

@description('Specifies the Network plugin mode used for building the Kubernetes network.')
@allowed([
  ''
  'Overlay'
])
param networkPluginMode string = ''

@description('Specifies the network policy used for building Kubernetes network. - calico or azure')
@allowed([
  'azure'
  'calico'
])
param networkPolicy string = 'azure'

@description('Specifies the eBPF dataplane used for building the Kubernetes network.')
@allowed([
  ''
  'cilium'
])
param ebpfDataplane string = ''

@description('Specifies the CIDR notation IP range from which to assign pod IPs when kubenet is used.')
param podCidr string = '192.168.0.0/16'

@description('A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges.')
param serviceCidr string = '172.16.0.0/16'

@description('Specifies the IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in serviceCidr.')
param dnsServiceIP string = '172.16.0.10'

@description('Specifies the CIDR notation IP range assigned to the Docker bridge network. It must not overlap with any Subnet IP ranges or the Kubernetes service address range.')
param dockerBridgeCidr string = '172.17.0.1/16'

@description('Specifies the sku of the load balancer used by the virtual machine scale sets used by nodepools.')
@allowed([
  'basic'
  'standard'
])
param loadBalancerSku string = 'standard'

@description('Specifies outbound (egress) routing method. - loadBalancer or userDefinedRouting.')
@allowed([
  'loadBalancer'
  'managedNATGateway'
  'userAssignedNATGateway'
  'userDefinedRouting'
])
param outboundType string = 'loadBalancer'

@description('Specifies the tier of a managed cluster SKU: Standard or Free')
@allowed([
  'Standard'
  'Free'
])
param skuTier string = 'Free'

@description('Specifies the version of Kubernetes specified when creating the managed cluster.')
param kubernetesVersion string = '1.18.8'

@description('Specifies the administrator username of Linux virtual machines.')
param adminUsername string = 'azureuser'

@description('Specifies the SSH RSA public key string for the Linux nodes.')
param sshPublicKey string

@description('Specifies the tenant id of the Azure Active Directory used by the AKS cluster for authentication.')
param aadProfileTenantId string = subscription().tenantId

@description('Specifies the AAD group object IDs that will have admin role of the cluster.')
param aadProfileAdminGroupObjectIDs array = []

@description('Specifies the upgrade channel for auto upgrade. Allowed values include rapid, stable, patch, node-image, none.')
@allowed([
  'rapid'
  'stable'
  'patch'
  'node-image'
  'none'
])
param upgradeChannel string = 'stable'

@description('Specifies whether to create the cluster as a private cluster or not.')
param enablePrivateCluster bool = true

@description('Specifies the Private DNS Zone mode for private cluster. When the value is equal to None, a Public DNS Zone is used in place of a Private DNS Zone')
param privateDNSZone string = 'none'

@description('Specifies whether to create additional public FQDN for private cluster or not.')
param enablePrivateClusterPublicFQDN bool = true

@description('Specifies whether to enable managed AAD integration.')
param aadProfileManaged bool = true

@description('Specifies whether to  to enable Azure RBAC for Kubernetes authorization.')
param aadProfileEnableAzureRBAC bool = true

@description('Specifies the unique name of of the system node pool profile in the context of the subscription and resource group.')
param systemAgentPoolName string = 'nodepool1'

@description('Specifies the vm size of nodes in the system node pool.')
param systemAgentPoolVmSize string = 'Standard_DS5_v2'

@description('Specifies the OS Disk Size in GB to be used to specify the disk size for every machine in the system agent pool. If you specify 0, it will apply the default osDisk size according to the vmSize specified.')
param systemAgentPoolOsDiskSizeGB int = 100

@description('Specifies the OS disk type to be used for machines in a given agent pool. Allowed values are \'Ephemeral\' and \'Managed\'. If unspecified, defaults to \'Ephemeral\' when the VM supports ephemeral OS and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to \'Managed\'. May not be changed after creation. - Managed or Ephemeral')
@allowed([
  'Ephemeral'
  'Managed'
])
param systemAgentPoolOsDiskType string = 'Ephemeral'

@description('Specifies the number of agents (VMs) to host docker containers in the system node pool. Allowed values must be in the range of 1 to 100 (inclusive). The default value is 1.')
param systemAgentPoolAgentCount int = 3

@description('Specifies the OS type for the vms in the system node pool. Choose from Linux and Windows. Default to Linux.')
@allowed([
  'Linux'
  'Windows'
])
param systemAgentPoolOsType string = 'Linux'

@description('Specifies the maximum number of pods that can run on a node in the system node pool. The maximum number of pods per node in an AKS cluster is 250. The default maximum number of pods per node varies between kubenet and Azure CNI networking, and the method of cluster deployment.')
param systemAgentPoolMaxPods int = 30

@description('Specifies the maximum number of nodes for auto-scaling for the system node pool.')
param systemAgentPoolMaxCount int = 5

@description('Specifies the minimum number of nodes for auto-scaling for the system node pool.')
param systemAgentPoolMinCount int = 3

@description('Specifies whether to enable auto-scaling for the system node pool.')
param systemAgentPoolEnableAutoScaling bool = true

@description('Specifies the virtual machine scale set priority in the system node pool: Spot or Regular.')
@allowed([
  'Spot'
  'Regular'
])
param systemAgentPoolScaleSetPriority string = 'Regular'

@description('Specifies the ScaleSetEvictionPolicy to be used to specify eviction policy for spot virtual machine scale set. Default to Delete. Allowed values are Delete or Deallocate.')
@allowed([
  'Delete'
  'Deallocate'
])
param systemAgentPoolScaleSetEvictionPolicy string = 'Delete'

@description('Specifies the Agent pool node labels to be persisted across all nodes in the system node pool.')
param systemAgentPoolNodeLabels object = {}

@description('Specifies the taints added to new nodes during node pool create and scale. For example, key=value:NoSchedule.')
param systemAgentPoolNodeTaints array = []

@description('Determines the placement of emptyDir volumes, container runtime data root, and Kubelet ephemeral storage.')
@allowed([
  'OS'
  'Temporary'
])
param systemAgentPoolKubeletDiskType string = 'OS'

@description('Specifies the type for the system node pool: VirtualMachineScaleSets or AvailabilitySet')
@allowed([
  'VirtualMachineScaleSets'
  'AvailabilitySet'
])
param systemAgentPoolType string = 'VirtualMachineScaleSets'

@description('Specifies the availability zones for the agent nodes in the system node pool. Requirese the use of VirtualMachineScaleSets as node pool type.')
param systemAgentPoolAvailabilityZones array = [
  '1'
  '2'
  '3'
]

@description('Specifies the unique name of of the user node pool profile in the context of the subscription and resource group.')
param userAgentPoolName string = 'nodepool1'

@description('Specifies the vm size of nodes in the user node pool.')
param userAgentPoolVmSize string = 'Standard_DS5_v2'

@description('Specifies the OS Disk Size in GB to be used to specify the disk size for every machine in the system agent pool. If you specify 0, it will apply the default osDisk size according to the vmSize specified..')
param userAgentPoolOsDiskSizeGB int = 100

@description('Specifies the OS disk type to be used for machines in a given agent pool. Allowed values are \'Ephemeral\' and \'Managed\'. If unspecified, defaults to \'Ephemeral\' when the VM supports ephemeral OS and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to \'Managed\'. May not be changed after creation. - Managed or Ephemeral')
@allowed([
  'Ephemeral'
  'Managed'
])
param userAgentPoolOsDiskType string = 'Ephemeral'

@description('Specifies the number of agents (VMs) to host docker containers in the user node pool. Allowed values must be in the range of 1 to 100 (inclusive). The default value is 1.')
param userAgentPoolAgentCount int = 3

@description('Specifies the OS type for the vms in the user node pool. Choose from Linux and Windows. Default to Linux.')
@allowed([
  'Linux'
  'Windows'
])
param userAgentPoolOsType string = 'Linux'

@description('Specifies the maximum number of pods that can run on a node in the user node pool. The maximum number of pods per node in an AKS cluster is 250. The default maximum number of pods per node varies between kubenet and Azure CNI networking, and the method of cluster deployment.')
param userAgentPoolMaxPods int = 30

@description('Specifies the maximum number of nodes for auto-scaling for the user node pool.')
param userAgentPoolMaxCount int = 5

@description('Specifies the minimum number of nodes for auto-scaling for the user node pool.')
param userAgentPoolMinCount int = 3

@description('Specifies whether to enable auto-scaling for the user node pool.')
param userAgentPoolEnableAutoScaling bool = true

@description('Specifies the virtual machine scale set priority in the user node pool: Spot or Regular.')
@allowed([
  'Spot'
  'Regular'
])
param userAgentPoolScaleSetPriority string = 'Regular'

@description('Specifies the ScaleSetEvictionPolicy to be used to specify eviction policy for spot virtual machine scale set. Default to Delete. Allowed values are Delete or Deallocate.')
@allowed([
  'Delete'
  'Deallocate'
])
param userAgentPoolScaleSetEvictionPolicy string = 'Delete'

@description('Specifies the Agent pool node labels to be persisted across all nodes in the user node pool.')
param userAgentPoolNodeLabels object = {}

@description('Specifies the taints added to new nodes during node pool create and scale. For example, key=value:NoSchedule.')
@allowed([
  'OS'
  'Temporary'
])
param userAgentPoolNodeTaints array = []

@description('Determines the placement of emptyDir volumes, container runtime data root, and Kubelet ephemeral storage.')
param userAgentPoolKubeletDiskType string = 'OS'

@description('Specifies the type for the user node pool: VirtualMachineScaleSets or AvailabilitySet')
@allowed([
  'VirtualMachineScaleSets'
  'AvailabilitySet'
])
param userAgentPoolType string = 'VirtualMachineScaleSets'

@description('Specifies the availability zones for the agent nodes in the user node pool. Requirese the use of VirtualMachineScaleSets as node pool type.')
param userAgentPoolAvailabilityZones array = [
  '1'
  '2'
  '3'
]

@description('Specifies whether the httpApplicationRouting add-on is enabled or not.')
param httpApplicationRoutingEnabled bool = false

@description('Specifies whether the Open Service Mesh add-on is enabled or not.')
param openServiceMeshEnabled bool = false

@description('Specifies whether the Kubernetes Event-Driven Autoscaler (KEDA) add-on is enabled or not.')
param kedaEnabled bool = false

@description('Specifies whether the Dapr extension is enabled or not.')
param daprEnabled bool = false

@description('Enable high availability (HA) mode for the Dapr control plane')
param daprHaEnabled bool = false

@description('Specifies whether the Flux V2 extension is enabled or not.')
param fluxGitOpsEnabled bool = false

@description('Specifies whether the Vertical Pod Autoscaler is enabled or not.')
param verticalPodAutoscalerEnabled bool = false

@description('Specifies whether the aciConnectorLinux add-on is enabled or not.')
param aciConnectorLinuxEnabled bool = false

@description('Specifies whether the azurepolicy add-on is enabled or not.')
param azurePolicyEnabled bool = true

@description('Specifies whether the kubeDashboard add-on is enabled or not.')
param kubeDashboardEnabled bool = false

@description('Specifies whether the pod identity addon is enabled..')
param podIdentityProfileEnabled bool = false

@description('Specifies whether the OIDC issuer is enabled.')
param oidcIssuerProfileEnabled bool = true

@description('Specifies the scan interval of the auto-scaler of the AKS cluster.')
param autoScalerProfileScanInterval string = '10s'

@description('Specifies the scale down delay after add of the auto-scaler of the AKS cluster.')
param autoScalerProfileScaleDownDelayAfterAdd string = '10m'

@description('Specifies the scale down delay after delete of the auto-scaler of the AKS cluster.')
param autoScalerProfileScaleDownDelayAfterDelete string = '20s'

@description('Specifies scale down delay after failure of the auto-scaler of the AKS cluster.')
param autoScalerProfileScaleDownDelayAfterFailure string = '3m'

@description('Specifies the scale down unneeded time of the auto-scaler of the AKS cluster.')
param autoScalerProfileScaleDownUnneededTime string = '10m'

@description('Specifies the scale down unready time of the auto-scaler of the AKS cluster.')
param autoScalerProfileScaleDownUnreadyTime string = '20m'

@description('Specifies the utilization threshold of the auto-scaler of the AKS cluster.')
param autoScalerProfileUtilizationThreshold string = '0.5'

@description('Specifies the max graceful termination time interval in seconds for the auto-scaler of the AKS cluster.')
param autoScalerProfileMaxGracefulTerminationSec string = '600'

// @description('Specifies the resource id of the Log Analytics workspace.')
// param workspaceId string

@description('Specifies the workspace data retention in days.')
param retentionInDays int = 60

@description('Specifies the location.')
param location string = resourceGroup().location

@description('Specifies the resource tags.')
param tags object

@description('Specifies whether to enable the Azure Blob CSI Driver. The default value is false.')
param blobCSIDriverEnabled bool = false

@description('Specifies whether to enable the Azure Disk CSI Driver. The default value is true.')
param diskCSIDriverEnabled bool = true

@description('Specifies whether to enable the Azure File CSI Driver. The default value is true.')
param fileCSIDriverEnabled bool = true

@description('Specifies whether to enable the Snapshot Controller. The default value is true.')
param snapshotControllerEnabled bool = true

@description('Specifies whether to enable Defender threat detection. The default value is false.')
param defenderSecurityMonitoringEnabled bool = false

@description('Specifies whether to enable ImageCleaner on AKS cluster. The default value is false.')
param imageCleanerEnabled bool = false

@description('Specifies whether ImageCleaner scanning interval in hours.')
param imageCleanerIntervalHours int = 24

@description('Specifies whether to enable Node Restriction. The default value is false.')
param nodeRestrictionEnabled bool = false

@description('Specifies whether to enable Workload Identity. The default value is false.')
param workloadIdentityEnabled bool = false

var sshPublicKeyString = loadTextContent('aks-fd-pls.pub')

// Variables
var diagnosticSettingsName = 'diagnosticSettings'
var logCategories = [
  'kube-apiserver'
  'kube-audit'
  'kube-audit-admin'
  'kube-controller-manager'
  'kube-scheduler'
  'cluster-autoscaler'
  'cloud-controller-manager'
  'guard'
  'csi-azuredisk-controller'
  'csi-azurefile-controller'
  'csi-snapshot-controller'
]
var metricCategories = [
  'AllMetrics'
]
var logs = [for category in logCategories: {
  category: category
  enabled: true
  retentionPolicy: {
    enabled: true
    days: retentionInDays
  }
}]
var metrics = [for category in metricCategories: {
  category: category
  enabled: true
  retentionPolicy: {
    enabled: true
    days: retentionInDays
  }
}]

// Resources
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2021-09-30-preview' existing = {
  name: managedIdentityName
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-08-01' existing = {
  name: virtualNetworkName
}

resource systemAgentPoolSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01' existing = {
  parent: virtualNetwork
  name: systemAgentPoolSubnetName
}

resource userAgentPoolSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01' existing = {
  parent: virtualNetwork
  name: userAgentPoolSubnetName
}

resource podSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01' existing = if (networkPlugin != 'Overlay') {
  parent: virtualNetwork
  name: podSubnetName
}

resource apiServerSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01' existing = {
  parent: virtualNetwork
  name: apiServerSubnetName
}

resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-11-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: 'Base'
    tier: skuTier
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}': {}
    }
  }
  properties: {
    kubernetesVersion: kubernetesVersion
    dnsPrefix: dnsPrefix
    agentPoolProfiles: [
      {
        name: toLower(systemAgentPoolName)
        count: systemAgentPoolAgentCount
        vmSize: systemAgentPoolVmSize
        osDiskSizeGB: systemAgentPoolOsDiskSizeGB
        osDiskType: systemAgentPoolOsDiskType
        vnetSubnetID: systemAgentPoolSubnet.id
        podSubnetID: networkPluginMode == 'Overlay' ? null : podSubnet.id
        maxPods: systemAgentPoolMaxPods
        osType: systemAgentPoolOsType
        maxCount: systemAgentPoolMaxCount
        minCount: systemAgentPoolMinCount
        scaleSetPriority: systemAgentPoolScaleSetPriority
        scaleSetEvictionPolicy: systemAgentPoolScaleSetEvictionPolicy
        enableAutoScaling: systemAgentPoolEnableAutoScaling
        mode: 'System'
        type: systemAgentPoolType
        availabilityZones: systemAgentPoolAvailabilityZones
        nodeLabels: systemAgentPoolNodeLabels
        nodeTaints: systemAgentPoolNodeTaints
        kubeletDiskType: systemAgentPoolKubeletDiskType
      }
      {
        name: toLower(userAgentPoolName)
        count: userAgentPoolAgentCount
        vmSize: userAgentPoolVmSize
        osDiskSizeGB: userAgentPoolOsDiskSizeGB
        osDiskType: userAgentPoolOsDiskType
        vnetSubnetID: userAgentPoolSubnet.id
        podSubnetID: networkPluginMode == 'Overlay' ? null : podSubnet.id
        maxPods: userAgentPoolMaxPods
        osType: userAgentPoolOsType
        maxCount: userAgentPoolMaxCount
        minCount: userAgentPoolMinCount
        scaleSetPriority: userAgentPoolScaleSetPriority
        scaleSetEvictionPolicy: userAgentPoolScaleSetEvictionPolicy
        enableAutoScaling: userAgentPoolEnableAutoScaling
        mode: 'User'
        type: userAgentPoolType
        availabilityZones: userAgentPoolAvailabilityZones
        nodeLabels: userAgentPoolNodeLabels
        nodeTaints: userAgentPoolNodeTaints
        kubeletDiskType: userAgentPoolKubeletDiskType
      }
    ]
    // https://learn.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed
    // # Create an SSH key pair using Azure CLI
    // az sshkey create --name "mySSHKey" --resource-group "myResourceGroup"
        // az sshkey create --name "aksSSHKey" --resource-group "rg-use2-446692-s4-aks-fd-pls"
        // => /subscriptions/34144584-4817-47a0-a912-bd00bae76495/resourceGroups/RG-USE2-446692-S4-AKS-FD-PLS/providers/Microsoft.Compute/sshPublicKeys/aksSSHKey
    // Private key is saved to "C:\Users\emberger\.ssh\1706557400_6375022".
    // Public key is saved to "C:\Users\emberger\.ssh\1706557400_6375022.pub"
    // # Create an SSH key pair using ssh-keygen
    // ssh-keygen -t rsa -b 4096 -C "azureuser" -m PEM -f /mnt/d/SshKeys/aks-fd-pls
    linuxProfile: {
      adminUsername: adminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshPublicKeyString
            // keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCiY/2qAFLrYd/+dWr7CTQkvVHYaZZG+XsLGfAZlhQqiTkkHbIjGH1NoPEfkpcXO3pBksKkMQKQmJVjSEgb16okFA8qRTPGiohk/6Ln2eFaXuZBBZLoxd+5G1kNMelZn7P7vWMKJ6dDL56Cfl7fvNQFF+tSWHpF2iTJPcdteE6h+IROwLAfSwRtmvwzi80HfW+dpgXGNYQ44skI1w1QPhMw4aEGLIkdPzro77iq2wQcktF/gxvRdpXxKK7iN0xjS7/iTNXReEZWe1qWxyycNjSrT6QRHWX0Abemmxl65VcWyCgYUPT2mWgFzw6EK3GtfnnE5gobdMR3ocd5wFl2wCSQdNdwaVbaZ7jDB/TkEt5tKfNTZHU764xfzq/4LRm1NDp5wASJNYp51m9EQz/J6artkcYYJk1XDcH4hkfgvstFXhqSAAMvX0SOEl7jjuLxGXc+235fQnpzrrr8fqHgQxIBxIuKCzavitZqp5514MW2MX4YwsWXFft54iSMcf+XsPXfG4WarScgzqiuG0QMVuOO0dlSPAr0NnzDH0PxrWra5nVLXxg06q/3k/Ygc4BjihxOSlU0iQu/l7PmsXlQ/aEEwtEwsi5Jf5xZ3Tf6hxMzuzFo+xvRB9ycJB2QQ7GLaxt0lgz/eyJBY6dJulkntLp0d9DkeYS+5T9ED2TERx7jkw== azureuser'
          }
        ]
      }
    }
    addonProfiles: {
      httpApplicationRouting: {
        enabled: httpApplicationRoutingEnabled
      }
      openServiceMesh: {
        enabled: openServiceMeshEnabled
        config: {}
      }
      // omsagent: {
      //   enabled: false
      //   config: {
      //     logAnalyticsWorkspaceResourceID: workspaceId
      //   }
      // }
      aciConnectorLinux: {
        enabled: aciConnectorLinuxEnabled
      }
      azurepolicy: {
        enabled: azurePolicyEnabled
        config: {
          version: 'v2'
        }
      }
      kubeDashboard: {
        enabled: kubeDashboardEnabled
      }
    }
    podIdentityProfile: {
      enabled: podIdentityProfileEnabled
    }
    oidcIssuerProfile: {
      enabled: oidcIssuerProfileEnabled
    }
    enableRBAC: true
    networkProfile: {
      networkPlugin: networkPlugin
      networkPluginMode: networkPlugin == 'azure' ? networkPluginMode : ''
      networkPolicy: networkPolicy
      podCidr: networkPlugin == 'kubenet' || networkPluginMode == 'Overlay' ? podCidr : null
      serviceCidr: serviceCidr
      dnsServiceIP: dnsServiceIP
      dockerBridgeCidr: dockerBridgeCidr
      outboundType: outboundType
      loadBalancerSku: loadBalancerSku
      loadBalancerProfile: null
      ebpfDataplane: networkPlugin == 'azure' ? ebpfDataplane : ''
    }
    workloadAutoScalerProfile: {
      keda: {
        enabled: kedaEnabled
      }
      verticalPodAutoscaler: {
        controlledValues: 'RequestsAndLimits'
        enabled: verticalPodAutoscalerEnabled
        updateMode: 'Off'
      }
    }
    aadProfile: {
      clientAppID: null
      serverAppID: null
      serverAppSecret: null
      managed: aadProfileManaged
      enableAzureRBAC: aadProfileEnableAzureRBAC
      adminGroupObjectIDs: aadProfileAdminGroupObjectIDs
      tenantID: aadProfileTenantId
    }
    autoUpgradeProfile: {
      upgradeChannel: upgradeChannel
    }
    autoScalerProfile: {
      'scan-interval': autoScalerProfileScanInterval
      'scale-down-delay-after-add': autoScalerProfileScaleDownDelayAfterAdd
      'scale-down-delay-after-delete': autoScalerProfileScaleDownDelayAfterDelete
      'scale-down-delay-after-failure': autoScalerProfileScaleDownDelayAfterFailure
      'scale-down-unneeded-time': autoScalerProfileScaleDownUnneededTime
      'scale-down-unready-time': autoScalerProfileScaleDownUnreadyTime
      'scale-down-utilization-threshold': autoScalerProfileUtilizationThreshold
      'max-graceful-termination-sec': autoScalerProfileMaxGracefulTerminationSec
    }
    apiServerAccessProfile: {
      enablePrivateCluster: enablePrivateCluster
      enableVnetIntegration: enableVnetIntegration
      privateDNSZone: enablePrivateCluster ? privateDNSZone : null
      enablePrivateClusterPublicFQDN: enablePrivateClusterPublicFQDN
      subnetId: enableVnetIntegration ? apiServerSubnet.id : null
    }
    securityProfile: {
      // defender: {
      //   logAnalyticsWorkspaceResourceId: workspaceId
      //   securityMonitoring: {
      //     enabled: defenderSecurityMonitoringEnabled
      //   }
      // }
      imageCleaner: {
        enabled: imageCleanerEnabled
        intervalHours: imageCleanerIntervalHours
      }
      nodeRestriction: {
        enabled: nodeRestrictionEnabled
      }
      workloadIdentity: {
        enabled: workloadIdentityEnabled
      }
    }
    storageProfile: {
      blobCSIDriver: {
        enabled: blobCSIDriverEnabled
      }
      diskCSIDriver: {
        enabled: diskCSIDriverEnabled
      }
      fileCSIDriver: {
        enabled: fileCSIDriverEnabled
      }
      snapshotController: {
        enabled: snapshotControllerEnabled
      }
    }
  }
}

// Dapr Extension
resource daprExtension 'Microsoft.KubernetesConfiguration/extensions@2022-04-02-preview' = if (daprEnabled) {
  name: 'dapr'
  scope: aksCluster
  properties: {
    extensionType: 'Microsoft.Dapr'
    autoUpgradeMinorVersion: true
    releaseTrain: 'Stable'
    configurationSettings: {
      'global.ha.enabled': '${daprHaEnabled}'
    }
    scope: {
      cluster: {
        releaseNamespace: 'dapr-system'
      }
    }
    configurationProtectedSettings: {}
  }
}

// Flux v2 Extension
resource fluxAddon 'Microsoft.KubernetesConfiguration/extensions@2022-04-02-preview' = if (fluxGitOpsEnabled) {
  name: 'flux'
  scope: aksCluster
  properties: {
    extensionType: 'microsoft.flux'
    autoUpgradeMinorVersion: true
    releaseTrain: 'Stable'
    scope: {
      cluster: {
        releaseNamespace: 'flux-system'
      }
    }
    configurationProtectedSettings: {}
  }
  dependsOn: [ daprExtension ] //Chaining dependencies because of: https://github.com/Azure/AKS-Construction/issues/385
}

// Diagnostics Settings
// resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
//   name: diagnosticSettingsName
//   scope: aksCluster
//   properties: {
//     workspaceId: workspaceId
//     logs: logs
//     metrics: metrics
//   }
// }

// Output
output id string = aksCluster.id
output name string = aksCluster.name
output fqdn string = aksCluster.properties.fqdn
output nodeResourceGroup string = aksCluster.properties.nodeResourceGroup
