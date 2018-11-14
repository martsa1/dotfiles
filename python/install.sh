#!/bin/bash
# One-liner executable to run through the installation of python on the local host.
pushd ..
ansible-playbook -i 'localhost,' -c local -K python/playbook.yml
popd
