dnf -y install git curl zsh util-linux-user which
timeout 10 sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp config/zsh/.zshrc ~
