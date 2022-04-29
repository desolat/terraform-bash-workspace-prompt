#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail
#set -o xtrace

# download and provide the prompt script
REPO_BRANCH="desolat/terraform-bash-workspace-prompt/TF_WORKSPACE"
if [ ! -d ~/.bash_scripts ]; then
  mkdir ~/.bash_scripts
fi
wget -q -O ~/.bash_scripts/terraform-bash-workspace-prompt.sh https://raw.githubusercontent.com/$REPO_BRANCH/terraform-bash-workspace-prompt.sh
chmod -R 755 ~/.bash_scripts

# load the prompt script for every interactive login shell
if [ -f ~/.bash_profile ]; then
  STARTUP_FILE=~/.bash_profile
elif [ -f ~/.bash_login ]; then
  STARTUP_FILE=~/.bash_login
elif [ -f ~/.profile ]; then
  STARTUP_FILE=~/.profile
else
  STARTUP_FILE=~/.bash_profile
fi
PROFILE_CODE="[[ -r ~/.bash_scripts/terraform-bash-workspace-prompt.sh ]] && . ~/.bash_scripts/terraform-bash-workspace-prompt.sh"
grep -qxF "$PROFILE_CODE" "$STARTUP_FILE" || echo "$PROFILE_CODE" >> $STARTUP_FILE
