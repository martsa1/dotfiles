Dotfiles
=========

This Role installs the dotfiles repository to the target machine, for the provided user.

Requirements
------------

N/A

Role Variables
--------------

`user`: The name of the user for which the dotfiles should be installed. Defaults to `{{ansible_user_id}}`
`dotfiles_root_path`: The absolute path at which the dotfiles repo should be cloned.  Defaults to `/home/{{user}}/code/personal`
`dotfiles_base_name`: The name of the dotfiles folder to clone into. Defaults to `dotfiles`
`dotfiles_repo`:  The git URL of the dotfiles to clone in. Defaults to `https://github.com/ABitMoreDepth/dotfiles.git`

Dependencies
------------

N/A

Example Playbook
----------------

Running the role is reasonably simple.  It will default to the user that runs the role by default, though it is easy enough to override the target user as follows:

    - hosts: servers
      roles:
         - role: dotfiles
           user: joebloggs

License
-------

MIT

Author Information
------------------

Sam Martin
https://abitmoredepth.com
