# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

# ZSH
sudo apt-get install curl zsh git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Vim
sudo apt-get install vim

# Tmux
sudo apt-get install tmux

# This needs to be improved
echo "
if [ -z "$TMUX" ]
then
    tmux attach -t base || tmux new -s base
fi
" >> ~/.zshrc

# SSH
ssh-keygen -t rsa -b 4096 -C "steffansluis@gmail.com" -f ~/.ssh/id_rsa -N ''

# Git
wget https://github.com/github/hub/releases/download/v2.2.9/hub-linux-arm64-2.2.9.tgz
tar -xzf hub-linux-arm64-2.2.9.tgz
sudo hub-linux-arm64-2.2.9/install

git config --global user.email "steffansluis@gmail.com"
git config --global user.name "Steffan Sluis"

# TODO: Set up ZSH completion

# Projects
mkdir -p ~/Projects
mkdir -p ~/Projects/TU
mkdir -p ~/Projects/SEC
mkdir -p ~/Projects/feedbackfruits

# Atom
sudo add-apt-repository ppa:webupd8team/atom -y
sudo apt-get update
sudo apt-get install atom

# Atom packages
apm install atom-typescript

# GNOME
# Did this manually

# Spotify
sudo sh -c 'echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
sudo apt-get update
sudo apt-get install spotify-client

# Fingerprint things?
# Fingerprint sensor not recognized on USB yet
sudo add-apt-repository ppa:fingerprint/fingerprint-gui
sudo apt update
sudo apt install libbsapi policykit-1-fingerprint-gui fingerprint-gui

sudo apt-get install default-jre

# Atom Beta (IDE)
wget https://atom-installer.github.com/v1.21.0-beta0/atom-amd64.deb?s=1505155030&ext=.deb
sudo dpkg -i atom-amd64.deb

apm-beta install atom-ide-ui
apm-beta install atom-typescript
apm-beta install ide-java
apm-beta install ide-typescript

# Eclipse IDE :(
wget http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/oomph/epp/oxygen/R/eclipse-inst-linux64.tar.gz
tar -xzf eclipse-inst-linux64.tar.gz
./eclipse-installer/eclipse-inst

# NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash
nvm install 8
nvm use 8
npm install -g yarn

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce
# sudo docker login

# Setup docker as non-sudo
sudo groupadd docker
sudo gpasswd -a $USER docker

# Mendeley
wget https://desktop-download.mendeley.com/download/apt/pool/main/m/mendeleydesktop/mendeleydesktop_1.17.11-stable_amd64.deb
sudo dpkg -i mendeleydesktop_1.17.11-stable_amd64.deb
