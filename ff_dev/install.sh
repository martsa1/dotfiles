#!/usr/bin/env bash
# One-liner executable to run through the installation of Firefox Developer Edition on the local host.
ansible-playbook -i 'localhost,' -c local -K playbook.yml
