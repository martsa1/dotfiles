#!/usr/bin/env bash
# One-liner executable to run through the installation of Kitty on the local host.
pushd ..
ansible-playbook -i 'localhost,' -c local -K setup_neovim.yml
popd
