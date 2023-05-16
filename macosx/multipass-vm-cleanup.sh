multipass unmount docker-vm
multipass stop docker-vm
multipass delete docker-vm
multipass purge
docker context rm docker-vm -f

multipass launch --name docker-vm --cpus 8 --mem 16G --disk 200G --cloud-init $HOME/dotfiles/macosx/cloud-config-$(uname -m).yml 22.04
multipass mount /Users docker-vm:/Users
multipass mount /private/tmp docker-vm:/tmp
docker context create docker-vm --docker "host=tcp://$(multipass list | grep docker-vm | awk '{print $3}'):2375"
docker context use docker-vm
