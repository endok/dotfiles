#!/bin/sh

dotfiles="$HOME/.dotfiles"

function link_dotfile() {
  local from=$1
  local to=$2

  if [ -L $to ]; then
    echo "$to already exists."
    return
  fi

  if [ -f $to -o -d $to ]; then
    echo "$to exists. mv $to $to.backup"`date +%Y%m%d%H%M%S`
    mv $to "$to.backup"`date +%Y%m%d%H%M%S`
  fi

  echo "ln -s $from $to"
  ln -s $from $to
}

link_dotfile "$dotfiles/dot.screenrc" "$HOME/.screenrc"
link_dotfile "$dotfiles/dot.vimrc" "$HOME/.vimrc"
link_dotfile "$dotfiles/dot.zshenv" "$HOME/.zshenv"
link_dotfile "$dotfiles/dot.zsh" "$HOME/.zsh"

# create file for chef
touch $dotfiles/.executed
