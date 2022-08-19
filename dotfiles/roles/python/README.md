Role Name
=========

Simple role which installs python versions 2 & 3, and installs Pipsi, along with a couple of base pipsi installs, including glances and powerline-status.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

The role isn't explicitly dependent on any others, but its highly recommended to run the accompanying dotfiles role prior to this one, especially when setting up a new account on a remote machine.

Example Playbook
----------------

    - hosts: servers
      roles:
         - role: python
           user: sam

License
-------

MIT
