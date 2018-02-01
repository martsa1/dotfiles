#1/usr/env sh
# One-liner executable to run through the installation of Kitty on the local host.
pushd ..
ansible-playbook -i 'localhost,' -c local -K setup_neovim.yml
popd
