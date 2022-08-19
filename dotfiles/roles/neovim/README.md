Neovim
=========

This role installs Neovim, alongside my personal neovim configs.  It also installs the base tooling needed for both ruby and python based Neovim extensions, finally it will pull in vim-plug from my configs and use it to install all the plugins that my setup is configured for.  In the process, it will clone in my dotfiles.


You can override the repo address (it must be git based), so long as it also uses vim plug (so the rest of this role can setup the plugins for you).
Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: abmd.neovim, x: 42 }

License
-------

MIT

Author Information
------------------

Sam Martin, https://abitmoredepth.com
