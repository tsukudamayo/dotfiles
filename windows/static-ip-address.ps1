# VM

sudo passwd ubuntu

sudo vim /etc/netplan/50-cloud-init.yaml

# # BEFORE
# 
# # This file is generated from information provided by
# # the datasource.  Changes to it will not persist across an instance.
# # To disable cloud-init's network configuration capabilities, write a file
# # /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# # network: {config: disabled}
# 
# network:
# 
#     ethernets:
# 
#         eth0:
# 
#             dhcp4: true
# 
#             match:
# 
#                 macaddress: 00:15:5d:df:51:0e
# 
#             set-name: eth0
# 
#     version: 2

# # AFTER
# # This file is generated from information provided by
# # the datasource.  Changes to it will not persist across an instance.
# # To disable cloud-init's network configuration capabilities, write a file
# # /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# # network: {config: disabled}
# 
# network:
# 
#     ethernets:
# 
#         eth0:
# 
#             dhcp4: false
# 
#             addresses:
# 
#                 - 192.168.254.2/24
# 
#             gateway4: 192.168.254.1
# 
#             match:
# 
#                 macaddress: 00:15:5d:df:51:0e
# 
#             set-name: eth0
# 
#     version: 2



# # client
# 
# New-VMSwitch -SwitchName WinNAT -SwitchType Internal
# 
# Get-NetAdapter
# 
# New-NetIPAddress -IPAddress 192.168.254.1 -PrefixLength 24 -ifIndex 5 
# 
# New-NetIPAddress -IPAddress 192.168.254.1 -PrefixLength 24 -InterfaceAlias "vEthernet (WinNAT)"
# 
# New-NetNat -Name WinNAT -InternalIPInterfaceAddressPrefix 192.168.254.0/24


