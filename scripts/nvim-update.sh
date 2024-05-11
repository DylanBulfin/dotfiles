#!/bin/bash

if [[ ! -e /usr/local/bin/nvim ]]; then
  echo "You are not using nighly, skipping update"
  exit
fi

cd /home/dylan/repos/neovim
git remote update

if git status -uno | grep -q "Your branch is up to date with 'origin/master'."; then
  if ! [[ $* == *-f* ]]; then
    echo "No new neovim commits, skipping"
    exit
  fi
fi

git pull

if ! make distclean; then
  echo "Failed to clean repo, aborting"
  exit
fi

if ! make CMAKE_BUILD_TYPE=RelWithDebInfo; then
  echo "Failed to build neovim, aborting"
  exit
fi

if ! make install; then
  echo "Failed to install neovim, aborting"
  exit
fi

echo "Neovim was installed successfully"
