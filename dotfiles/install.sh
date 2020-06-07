#/usr/env sh

# Ensure we have ansible to work with
command -v ansible >/dev/null 2>&1
if [ $? -ne 0 ]; then
  # We don't have access to ansible, attempt to install it
  echo "Couldn't find Ansible, do you wish to install it?"
  read -p "Install Ansible (y/n)? " continueOrNot
  if [ $continueOrNot == "y" -o $continueOrNot == "Y" ]; then
    sudo -H pip install git+git://github.com/ansible/ansible.git@stable-2.4
  else
    exit 1
  fi
fi

# One-liner executable to run through the installation of Kitty on the local host.
ansible-playbook -i 'localhost,' -c local -K playbook.yml
