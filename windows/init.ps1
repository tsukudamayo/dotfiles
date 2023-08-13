mkdir $HOME\local
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install packages.config
git config --global user.email tsukudamayo@gmail.com
git config --global user.name tsukudamayo
git config --global core.autocrlf true
wsl --install -d Debian
