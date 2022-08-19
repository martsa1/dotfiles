import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')

# Issues with using host.file (the normal way to test these kinds of things)
# are due to the way permissions are setup within the test container.  Using
# the same technique that testinfra uses internally here:
# https://github.com/philpep/testinfra/blob/master/testinfra/modules/file.py#L42


def test_pipsi_installed(host):
    with host.sudo():
        host.run_expect(
            [0],
            'test -e /home/example/.local/bin/pipsi',
        )
        host.run_expect(
            [0],
            'test -L /home/example/.local/bin/pipsi',
        )


def test_glances_installed(host):
    with host.sudo():
        glances_file = host.run(
            'test -e /home/example/.local/bin/glances'
        ).rc

        glances_symlink = host.run(
            'test -L /home/example/.local/bin/glances'
        ).rc

    assert glances_file == 0
    assert glances_symlink == 0


def test_pyenv_installed(host):
    with host.sudo():
        pyenv_file = host.run(
            'test -e /home/example/code/personal/pyenv/bin/pyenv'
        ).rc

    assert pyenv_file == 0
