multipass unmount docker-vm || true
multipass stop docker-vm || true
multipass delete docker-vm || true
multipass purge || true
docker context rm docker-vm -f || true

multipass launch --name docker-vm --cpus 8 --mem 16G --disk 200G \
  --cloud-init "$HOME/dotfiles/macosx/cloud-config-$(uname -m).yml" lts

multipass mount /Users docker-vm:/Users
# NG: /tmp をホストマウントしない
# multipass mount /private/tmp docker-vm:/tmp

# 代替：必要なら別パスにマウント
multipass mount /private/tmp docker-vm:/mnt/host-tmp

IP="$(multipass list | awk '$1=="docker-vm"{print $3}')"
docker context create docker-vm --docker "host=tcp://${IP}:2375"
docker context use docker-vm
