Role Name
=========

This role will install and configure i3 and provision my preferred config into place ready for use.

Requirements
------------

N/A

Role Variables
--------------

Defaults that can be overridden:
 - user: "sam"
 - personal_code_base_dir: "/home/{{user}}/code/personal"
 - dotfiles_base_dir: "{{personal_code_base_dir}}/dotfiles"
 - config_base_dir: "/home/{{user}}/.config"

Change the above settings to adjust where things are setup/installed to by default.

Dependencies
------------

Depends on my dotfiles role in order to get everything setup correctly.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         -  role: i3wm
            user: example

License
-------

MIT
