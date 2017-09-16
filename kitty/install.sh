#1/usr/env sh
# One-liner executable to run through the installation of Kitty on the local host.
ansible-playbook -i 'localhost,' -c local -K playbook.yml
