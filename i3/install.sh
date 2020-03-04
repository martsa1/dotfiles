#!/bin/bash
# One-liner executable to run through the installation of Kitty on the local host.
ANSIBLE_ROLES_PATH=$(pwd)/../roles ansible-playbook -i 'localhost,' -c local -K playbook.yml
