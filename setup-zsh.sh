#!/bin/bash
set -euo pipefail

PWD_DIR=`pwd`
OH_MY_ZSH_DIR=$HOME/.oh-my-zsh
CUSTOM_DIR=$OH_MY_ZSH_DIR/custom
PLUGIN_DIR=$CUSTOM_DIR/plugins
THEMES_DIR=$CUSTOM_DIR/themes
CONFIG_DIR=$HOME/.config
ZSH_CMD=`which zsh`
echo $ZSH_CMD

if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v curl &> /dev/null; then
    echo -e "zsh, git, curl are already installed\n"
else
    if brew install git zsh curl ; then
        echo -e "Installed git zsh and curl\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git \n" && exit
    fi
fi

if [ -d $OH_MY_ZSH_DIR ]; then
    echo -e "Oh my zsh already installed, updating..."
    $ZSH_CMD -c -i "omz update"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo -e "Installing plugins\n"

if [ -d $THEMES_DIR/powerlevel10k ]; then
    cd $THEMES_DIR/powerlevel10k && git pull
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${THEMES_DIR}/powerlevel10k
fi

if [ -d $PLUGIN_DIR/k ]; then
    cd $PLUGIN_DIR/k && git pull
else
    git clone --depth 1 https://github.com/supercrabtree/k $PLUGIN_DIR/k
fi

if [ -d $PLUGIN_DIR/zsh-autosuggestions ]; then
    cd $PLUGIN_DIR/zsh-autosuggestions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $PLUGIN_DIR/zsh-autosuggestions
fi

if [ -d $PLUGIN_DIR/zsh-completions ]; then
    cd $PLUGIN_DIR/zsh-completions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-completions $PLUGIN_DIR/zsh-completions
fi

if [ -d $PLUGIN_DIR/zsh-history-substring-search ]; then
    cd $PLUGIN_DIR/zsh-history-substring-search && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search $PLUGIN_DIR/zsh-history-substring-search
fi

if [ -d $PLUGIN_DIR/zsh-syntax-highlighting ]; then
    cd $PLUGIN_DIR/zsh-syntax-highlighting && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGIN_DIR/zsh-syntax-highlighting
fi

echo -e "Removing files and re-linking\n"
rm -f ~/.zshrc
ln -s $PWD_DIR/zshrc ~/.zshrc
rm -f $CUSTOM_DIR/aliases.zsh
ln -s $PWD_DIR/aliases.zsh $CUSTOM_DIR/aliases.zsh
rm -f $CUSTOM_DIR/autosuggest.zsh
ln -s $PWD_DIR/autosuggest.zsh $CUSTOM_DIR/autosuggest.zsh


# source ~/.zshrc
echo -e "\nSudo access is needed to change default shell.\n"


if chsh -s $ZSH_CMD ; then
    echo -e "Installation Successful, exit terminal and enter a new session"
else
    echo -e "Something is wrong"
fi
exit
