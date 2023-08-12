multipass launch --name docker-vm --cpus 8 --mem 8G --disk 50G --cloud-init $HOME/dotfiles/windows/cloud-config-x86_64.yml 22.04
multipass mount /Users docker-vm:/Users
multipass mount /private/tmp docker-vm:/tmp
$multipass_ip =  multipass list | Out-String -Stream | Select-String "docker-vm" | Out-String -Stream | Select-String -Pattern "172.17.0.\d{1,3}" | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value}
docker context create docker-vm --docker "host=tcp://${multipass_ip}:2375"
docker context use docker-vm
