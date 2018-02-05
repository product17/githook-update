#!/bin/bash

# set config vars
hasRepo="false"
partial="false"
remoteName="github" # The name of the remote in git
repo="artpup-drupal" # Part of the repo url

# get the info
remote="$(git remote -v | tr '\n' ' ')"

# split the info
IFS=' '
read -ra ADDR <<< "$remote"

# check the info
for i in "${ADDR[@]}"; do
  if [[ "$i" != "("* ]]; then
    if [[ "$i" == "$remoteName"* && "$i" == *"$repo"* ]]; then
      hasRepo="true"
      break;
    fi

    if [[ "$i" == "$remoteName"* ]]; then
      # remote name exists
      partial="true"
      echo -e "\nIt looks like \033[1;36m$remoteName\033[0m remote is pointing to a different repo"
      echo -e "to remove the remote run:\n"
      echo -e "\033[1;36m    git remote remove $remoteName\033[0m\n"
      break;
    fi
  fi
done

if [[ "$hasRepo" == "true" ]]; then
  echo -e "\n\033[1;32mRemotes are all setup! Let's update the hooks now...\033[0m\n"
elif [[ "$partial" == "true" ]]; then
  echo -e "\033[1;33mTry running this script again after you've made your changes\033[0m\n"
else
  echo -e "\n\n\033[1;31m[WARNING] Missing github remote\033[0m\n\n"
  echo -e "\033[1;33mSetting up the github remote...\033[0m"
  git remote add github git@github.com:artpup-developers/artpup-drupal.git
  echo -e "\033[1;32mgithub remote has been added, in the future please use:\033[0m\n"
  echo -e "\033[1;36m    git push github <branch_name>\033[0m\n"
fi

# Wipe the hook files
> .git/hooks/pre-push

# Write the pre-push hook
cat > .git/hooks/pre-push <<'endmsg'
remote="$1"
url="$2"
read local_ref local_sha remote_ref remote_sha

if [[ "$remote" != "github" ]]; then
  echo "\n\n\033[1;31m[WARNING] Please push to the \033[1;36mgithub\033[1;31m remote on your feature branch\033[0m\n"
  echo "\033[1;32m[Example]:\033[0m \033[1;36mgit push github <branch_name>\033[1;31m\n"
  exit 1;
fi

if [[ "$local_ref" == *"master" ]]; then
  echo "\n\n\033[1;31m[WARNING] You are pushing to the \033[1;36mmaster\033[1;31m branch, please use a feature branch\033[0m\n"
  echo "\033[1;32m[Example]:\033[0m \033[1;36mgit push github cool_idea\033[1;31m\n"
  exit 1;
fi
echo $remote
endmsg

# Make all the files executable
chmod +x .git/hooks/pre-push