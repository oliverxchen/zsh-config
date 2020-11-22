#!/bin/bash
set -euo pipefail

PWD_DIR=`pwd`
OH_MY_ZSH_DIR=$HOME/.oh-my-zsh
CUSTOM_DIR=$OH_MY_ZSH_DIR/custom
PLUGIN_DIR=$CUSTOM_DIR/plugins
THEMES_DIR=$CUSTOM_DIR/themes
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

echo -e "Installing plugins and theme\n"

if [ -d $THEMES_DIR/spaceship-prompt ]; then
    cd $THEMES_DIR/spaceship-prompt && git pull
else
    git clone --depth 1 https://github.com/denysdovhan/spaceship-prompt.git $THEMES_DIR/spaceship-prompt
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

echo -e "Removing ~/.zshrc and re-linking\n"
rm ~/.zshrc
ln -s ~/zsh-config/zshrc ~/.zshrc
rm $THEMES_DIR/spaceship.zsh-theme
ln -s "$THEMES_DIR/spaceship-prompt/spaceship.zsh-theme" "$THEMES_DIR/spaceship.zsh-theme"
echo $PWD_DIR
cp $PWD_DIR/aliases.zsh $CUSTOM_DIR/aliases.zsh

# source ~/.zshrc
echo -e "\nSudo access is needed to change default shell\n"

if chsh -s $ZSH_CMD ; then
    echo -e "Installation Successful, exit terminal and enter a new session"
else
    echo -e "Something is wrong"
fi
exit
