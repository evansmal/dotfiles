# dotfiles

## Getting Started

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

## Setting up remote development machine

```sh
ansible-playbook -i hosts.yaml work.yaml -u esmal -t <TAGS>
```

## Galaxy Setup

The `galaxy_setup.yaml` playbook sets up a complete development environment for Tenstorrent Galaxy hardware systems. It installs development tools, clones and builds the tt-metal repository, and configures the system.

### Basic Usage

```sh
ansible-playbook -i galaxy_hosts.yaml galaxy_setup.yaml -u esmal
```

### Available Tags

You can run specific parts of the setup using tags:

- `install-node` - Install Node.js
- `install-nvim` - Install Neovim and plugins
- `metal` - Clone and build tt-metal repository
- `config` - Synchronize configuration files (Neovim, tmux, ird)
- `bashrc` - Configure bashrc settings (history, aliases)
- `fzf` - Install and configure fzf
- `sanity` - Run hardware sanity tests
- `always` - Pre-flight system checks (runs automatically)

### Examples

Install everything:
```sh
ansible-playbook -i galaxy_hosts.yaml galaxy_setup.yaml -u esmal
```

Only install Node.js and Neovim:
```sh
ansible-playbook -i galaxy_hosts.yaml galaxy_setup.yaml -u esmal --tags install-node,install-nvim
```

Clone and build tt-metal with a specific SSH key:
```sh
ansible-playbook -i galaxy_hosts.yaml galaxy_setup.yaml -u esmal --tags metal -e "tt_metal_ssh_key=/path/to/ssh/key"
```

Run only sanity tests:
```sh
ansible-playbook -i galaxy_hosts.yaml galaxy_setup.yaml -u esmal --tags sanity
```

### SSH Key for tt-metal Clone

If you need to specify an SSH key for cloning the tt-metal repository, use the `tt_metal_ssh_key` variable:

```sh
ansible-playbook -i galaxy_hosts.yaml galaxy_setup.yaml -u esmal --tags metal -e "tt_metal_ssh_key=/path/to/ssh/key"
```

### Bash Aliases

The playbook adds a `reset-multihost-galaxy` alias to your `.bashrc` that resets the Galaxy hardware:

```bash
alias reset-multihost-galaxy='mpirun-ulfm --hostfile /etc/mpirun/hostfile --mca btl self,tcp --mca hwloc_base_binding_policy none --tag-output bash -c "source python_env/bin/activate && tt-smi -glx_reset --snapshot_no_tty"'
```

## Hardware Sanity Tests

The sanity tests verify that the tt-metal repository is properly set up and the hardware is functioning correctly. There are separate test suites for dual galaxy and quad galaxy configurations.

### Running Dual Galaxy Sanity Tests

#### Standalone

```sh
ansible-playbook -i galaxy_hosts.yaml sanity_tests.yaml -u esmal
```

This runs the dual galaxy sanity tests (`dual_galaxy_sanity_tests_tasks.yaml`).

#### Via galaxy_setup.yaml

```sh
ansible-playbook -i galaxy_hosts.yaml galaxy_setup.yaml --tags sanity -u esmal
```

### Running Quad Galaxy Sanity Tests

To run quad galaxy tests, you'll need to create a playbook that imports `quad_galaxy_sanity_tests_tasks.yaml`:

```yaml
---
- hosts: all
  gather_facts: yes
  tasks:
    - name: Import quad galaxy sanity test tasks
      ansible.builtin.import_tasks: quad_galaxy_sanity_tests_tasks.yaml

  environment:
    PATH: "/usr/bin:{{ ansible_env.PATH }}"
```

### Prerequisites

Before running the sanity tests, ensure:
- The tt-metal repository is cloned at `/home/<user>/wa/tt-metal`
- The repository has been built with `./build_metal.sh -c --build-tests`
- The `source.sh` file exists in the tt-metal directory
- Required test files and binaries are present
- Rank bindings configuration files exist for your galaxy configuration

The tests will fail early with clear error messages if any prerequisites are missing.

### Dual Galaxy Tests Included

The dual galaxy sanity tests (`dual_galaxy_sanity_tests_tasks.yaml`) run in the following order:

1. **Intermesh health check** - Verifies intermesh link configuration (8 chips with 4 links each, 32 total links)
2. **Intermesh link test** - Tests cluster intermesh link functionality
3. **Basic hardware sanity test** - Verifies MPI communication works by running a simple echo command
4. **Fabric 2D sanity test** - Tests 2D fabric routing functionality
5. **Fabric 1D sanity test** - Tests 1D fabric routing functionality

Each test will display ✅ PASS or ❌ FAIL status upon completion, and output is shown during test execution.

### Quad Galaxy Tests

The quad galaxy sanity tests (`quad_galaxy_sanity_tests_tasks.yaml`) include:
- Basic quad galaxy sanity test using `quad_galaxy_rank_bindings.yaml` and hosts `g05glx01,g05glx02,g05glx03,g05glx04`
