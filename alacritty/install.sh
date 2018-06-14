#1/usr/env sh
# One-liner executable to run through the installation of Alacritty on the local host.
ansible-playbook -i 'localhost,' -c local -K playbook.yml
