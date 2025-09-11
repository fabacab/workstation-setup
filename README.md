# Workstation Setup

This project is a simple [Ansible Collection](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html) that distributes an opinionated [Playbook](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html) that can be used to ensure a local engineer's workstation has all the necessary tools they will need to perform their work. This is intended to speed up the technical onboarding process in the event an engineer finds themselves in a situation where they need to use an alternate device, have switched devices and cannot restore from a backup, or are otherwise forced to "start from scratch." It also provides developers with a consistent approach to workstation configuration and defines robust conventions that are easy to communicate and reason about.

## Pre-requisites

As this is an Ansible Playbook, Ansible is the only dependency, so [install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html). Usually, regardless of your Operating System this is as simple as:

```sh
# Install Ansible.
pip3 install --user --upgrade ansible

# On some systems, like macOS, ensure the right directory is included
# in the shell's search path. For example:
export PATH="$PATH:$HOME/Library/Python/3.9/bin"
```

In addition to the above software installation, before you run this Playbook, you must also have completed the following steps.

1. You have a GitHub account and have:
    1. [Verified your GitHub email address](https://docs.github.com/en/get-started/signing-up-for-github/verifying-your-email-address).
    1. [Set up GitHub 2FA authentication](https://help.github.com/en/articles/securing-your-account-with-two-factor-authentication-2fa).
    1. [Set up GitHub SSH access](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

## Install Ansible Collection

You can install this collection in one of two ways. You don't need to do both. Either method will do.

You can install directly from a remote Git repository:

```sh
ansible-galaxy collection install git@github.com:fabacab/workstation-setup.git
```

Or you can build and install from source:

```sh
git clone git@github.com:fabacab/workstation-setup.git
cd workstation-setup
make install
```

## Configure your workstation

You are most certainly special and unique, so you can partly customize your workstation setup:

```sh
cp workstation-sample.yaml workstation.yaml
$EDITOR workstation.yaml
```

## Run the `main.yaml` Playbook

```sh
ansible-playbook --ask-become-pass --extra-vars "@workstation.yaml" ~/.ansible/collections/ansible_collections/fabacab/workstation_setup/playbooks/main.yaml
```

When prompted for the "`BECOME` password" ([Ansible's privilege escalation](https://docs.ansible.com/ansible/latest/user_guide/become.html)), enter the password you normally use to run commands with `sudo`.

## What this Playbook does *not* do

There are some steps that this Playbook does not attempt to automate. This section lists those and hints towards how to handle them.

### Authentication credentials

This Playbook does *not* configure authentication credentials for various SaaS products, such as GitHub, for example. Such credentials, usually in the form of API keys, [tokens for GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) or [Docker Hub](https://docs.docker.com/security/for-developers/access-tokens/) should go into an "auth file" (namely, `.workstation.auth.sh` file in [your user's home *data* directory](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) (i.e., `${XDG_DATA_DIR:-~/.local/share}/.workstation.auth.sh` by default, not necessarily your home folder itself) formatted as shell `export` lines, like this:

```sh
# In $XDG_DATA_DIR/.workstation.auth.sh, conventional
# API token file for an engineer's workstation.
export GITHUB_TOKEN="ghp_YOUR_TOKEN_HERE" # Comment your tokens!
export CIRCLECI_TOKEN="..."               # Workstation local dev, for example
export DOCKER_HUB_RO_TOKEN="dckr_pat_..." # Read-only personal access token for Docker Hub.
```

> :bulb: Consider using your passowrd manager, such as your Bitwarden or 1Password account to store these credentials. Then can refer to those values as [1Password Secret References](https://developer.1password.com/docs/cli/secret-references/) in the local file. For example:
>
> ```sh
> # Simple `.workstation.auth.sh` example using 1Password Secret References:
> export GITHUB_TOKEN="op://Private/GitHub Personal Access Token/credential"
> ```
>
> This helps reduce exposure of the given values from being written to the workstation's local disk.

## Troubleshooting

This section offers a few quick fixes for issues that may arise when using the setup playbook.

### Task failure

If a task should fail, you can skip it by `--step`ing through the tasks one at a time or by beginning the run from the subsequent task using a combination of `--list-tasks` and `--start-at-task`. See [Executing playbooks for troubleshooting](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_startnstep.html) for more information.
