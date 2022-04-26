# dotfiles

## Getting Started

Install some pre-requisites:

```sh
sudo pacman -S ansible git
```

Clone the repository and run the playbook:

```sh
git clone https://github.com/evansmal/dotfiles.git
ansible-playbook playbook.yml -K
```

Install the other tools that aren't automated using ansible:

```sh
./scripts/google-chrome
./scripts/neovim
./scripts/nvidia-container-toolkit
./scripts/fonts
```

Once SSH keys are setup you switch to the ssh remote:

```sh
git remote set-url git@github.com:evansmal/dotfiles.git
```
