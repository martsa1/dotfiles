Dotfiles
=========

This Role installs the users dotfiles repository to the target machine.

Requirements
------------

N/A

Role Variables
--------------

`target_user`: The name of the user for which the dotfiles should be installed. Defaults to `{{ansible_user_id}}`
`dotfiles_root_path`: The absolute path at which the dotfiles repo should be cloned.  Defaults to `/home/{{target_user}}/code/personal`
`dotfiles_base_name`: The name of the dotfiles folder to clone into. Defaults to `dotfiles`
`dotfiles_repo`:  The git URL of the dotfiles to clone in. Defaults to `https://github.com/ABitMoreDepth/dotfiles.git`

Dependencies
------------

- ABMD.user - Used to setup the initial user account.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: dotfiles, target_user: sam }

License
-------

MIT

Author Information
------------------

Sam Martin
https://abitmoredepth.com
