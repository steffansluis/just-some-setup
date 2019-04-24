# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

# ZSH
sudo apt-get install curl zsh git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp .zshrc ~

# Vim
sudo apt-get install vim

# Tmux
sudo apt-get install tmux
cp .tmux.conf ~

# This needs to be improved
echo "
if [ -z "\$TMUX" ]
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
eval "$(hub alias -s)"

mkdir -p ~/.zsh/completions
curl https://raw.githubusercontent.com/github/hub/master/etc/hub.zsh_completion > ~/.zsh/completions/_hub

echo "
fpath=(~/.zsh/completions \$fpath)
autoload -U compinit && compinit
" >> ~/.zshrc

git config --global user.email "steffansluis@gmail.com"
git config --global user.name "Steffan Sluis"
git config --global core.editor "vim"

# TODO: Set up ZSH completion

# Projects
mkdir -p ~/Projects
mkdir -p ~/Projects/TU
mkdir -p ~/Projects/SEC
mkdir -p ~/Projects/knowledge-express
mkdir -p ~/Projects/feedbackfruits

mkdir -p ~/Projects/feedbackfruits/knowledge

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

# Skype
wget https://repo.skype.com/latest/skypeforlinux-64.deb
sudo dpkg -i skypeforlinux-64.deb

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
a

echo "
alias atom=atom-beta
alias apm=apm-beta
" >> ~/.zshrc

# Eclipse IDE :(
wget http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/oomph/epp/oxygen/R/eclipse-inst-linux64.tar.gz
tar -xzf eclipse-inst-linux64.tar.gz
./eclipse-installer/eclipse-inst

# NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash
nvm install 8
nvm use 8
npm install -g yarn

# RVM
sudo apt-get install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get install rvm

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

# Heroku CLI
# Note: requires sudo, so should be done differently
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Heroku CLI plugins
heroku plugins:install heroku-accounts

# CircleCI CLI
sudo curl -o /usr/local/bin/circleci https://circle-downloads.s3.amazonaws.com/releases/build_agent_wrapper/circleci
sudo chmod +x /usr/local/bin/circleci

# Mendeley
wget https://desktop-download.mendeley.com/download/apt/pool/main/m/mendeleydesktop/mendeleydesktop_1.17.11-stable_amd64.deb
sudo dpkg -i mendeleydesktop_1.17.11-stable_amd64.deb

# Redis
sudo apt install build-essential tcl
cd /opt
sudo curl -O http://download.redis.io/redis-stable.tar.gz
sudo tar xzvf redis-stable.tar.gz
cd /opt/redis-stable
sudo chown -R steffan:steffan /opt/redis-stable
make
make test
sudo make install
sudo mkdir /etc/redis
sudo cp /opt/redis-stable/redis.conf /etc/redis

# TODO: Fix the editing part
sudo vim /etc/redis/redis.conf
# Make two changes there:
# supervised no to supervised systemd
# dir to dir /var/lib/redis # for persistent data dump

sudo vim /etc/systemd/system/redis.service

# [Unit]
# Description=Redis In-Memory Data Store
# After=network.target
#
# [Service]
# User=redis
# Group=redis
# ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
# ExecStop=/usr/local/bin/redis-cli shutdown
# Restart=always
#
# [Install]
# WantedBy=multi-user.target

sudo adduser --system --group --no-create-home redis
sudo mkdir /var/lib/redis   # create directory
sudo chown redis:redis /var/lib/redis   # make redis own /var/lib/redis
sudo chmod 770 /var/lib/redis   # adjust permission


# Postgres
sudo apt-get install postgresql postgresql-contrib libpq-dev
sudo -u postgres createuser steffan -s

# MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get install -y mongodb-org
sudo systemctl start mongod

# ElasticSearch
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt-get update
sudo apt-get install elasticsearch

# VirtualBox
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list'
sudo apt-get update
sudo apt-get install virtualbox-5.1

# Python
sudo apt-get install python-virtualenv python-pip
