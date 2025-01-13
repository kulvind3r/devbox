# DevBox Setup

Automate setting up a development environment on Mac and potentially Windows machines in future.

Dev environment runs as a guest VM on Host OS. Lima based VM on Mac and WSL on Windows. 

End user is expected to use the remote dev environment feature of their IDE of choice to connect with VM via SSH and use the guest vm for all dev operations, build, testing, debugging etc.

Filesystem of Host machine is mounted with writes enabled within the guest os to provide seamless file sharing, editing and transfer. Clipboard sharing is a non-issue as the IDE / Editors are run by the Host OS.

## Present Support

Code has been tested in following configuration

### Mac
- __Host OS__ : macOS Sonoma 14.7 on Apple M2  Chip

- __Guest OS__ : ubuntu 24.04 LTS ARM

- __Host OS IDE__ : VS Code 1.96.2

## Usage

- For Mac machines simply run `./mac.sh <role>`. Roles are the yaml files under ansible directory. They will also be printed for you if you run the command without providing a role.

- For Windows machines there will be a similar powershell based automation coming soon.

## Dev Environment Flavors

More flavors to come in future.

### Common

Available in all dev environments with the goal of providing fundamental dev tools to all developers, irrespective of their specialization.

#### Languages
- Python 3.12

#### Utilites
- docker
- ansible
- Hashicorp vault
- helm
- kubectl
- awscli
- [k9s](https://k9scli.io/): Terminal based UI to Work with kubernetes clusters like a sane person. Stop typing mile long kubectl commands for everything.
- [tig](https://github.com/jonas/tig) : High performance terminal based git repo browser.
- [autojump](https://github.com/wting/autojump) : A cd command that learns. Switch already browsed directories by fuzzy matching director name.
- vim
- [bat](https://github.com/sharkdp/bat): A replacement for gnu `cat` on steroids.
- [jq](https://jqlang.github.io/jq/): Command line JSON Processor.
- [yq](https://github.com/mikefarah/yq): Command line YAML and XML Processor.
- git
- [git-delta](https://github.com/dandavison/delta): Syntax Highlighting pager for git, diff, and blame output.
- m4
- unzip
- [silversearcher-ag](https://github.com/ggreer/the_silver_searcher): Lightning fast code searching, just run `ag <string>`
- [fzf](https://github.com/junegunn/fzf): Command line fuzzy finder. High power reverse lookup in terminal. replaces `ctrl+r`
- coreutils
- ca-certificates
- apt-transport-https
- jsonnet
- [Mozilla SOPS](https://github.com/getsops/sops): Quick simple secret management if not the best.

#### Aliases and Configurations
- `gm <git_command>` : Run any git command like pull, status etc. across all git repos in a directory. Update all your repos in one command
- `gl` : A highly dense git log for any git repo. Provides all useful information in one line manner with distinct color highlights
- preconfigured vim with color theme, numbers enabled and polygot plugin to enable 600+ syntax highlights in vim. Requires running `PlugInstall` manually once in vim.
- `.bash_env`: File for cleanly exporting any global environment variables following the pattern of `.bash_aliases` in bash shell.


### Infra

Tools and Utilities focused towards infrastructure development and coding avaialble for environments provisioned with role `infra-dev`.

#### Utilities
- [microk8s](https://microk8s.io/): Ready to go Lightweight single node fully featured kubernetes cluster in your vm for local prototyping and testing.
- Hashicorp Terraform
- Hashicorp Packer

### Python

Tools and Utilities focused towards python development and coding avaialble for environments provisioned with role `python-dev`.

#### Utilities
- pip3
- [uv](https://github.com/astral-sh/uv) : Extremely fast Python package and project manager, written in Rust