# A set of commands that are useful to remember
# List available targets
# > make [list] 

GIT_VERSION ?= master4cmre
export GIT_VERSION

# Make arguments need to be exported to make them accessible to included makefile 
# BUILD_NUMBER is only used by vagrant-upload; should be set by Jenkins but defaults to 0
# BUILD_NUMBER ?= 0
# export BUILD_NUMBER
# Has this been called from vagrant? ([0], 1)
VAGRANT ?= 0
export VAGRANT

# When using with vagrant, the executable bit can be set on this file and ansible complains.
# Allow user to override
VAULT_PASSWORD_FILE ?= target/.vault_password_file
export VAULT_PASSWORD_FILE

# The directory to load the inventory file from: environments/$(env_name)/hosts
# Defaults to the local vagrant environment
env_name ?= vagrant
export env_name

# Display debug trace and logs (0-5)
debug ?= 0
export debug

# Build from the clusterDetails.json/nodeGroups/fullBuildImageName
# This deploys to a base image - generally centos/7.
FULL_BUILD ?= false
export FULL_BUILD

# Build the server profile unless another is specified on the command line.
profile ?= server
export profile

# Used to identify VMs to destroy in target 'vagrant-destroy-all'
# Wildcard matches both provisioner and appliance.
playbook_name = github.dcos-.*22

ifneq (,$(wildcard ./scripts/ansible-playbook.common-scripts/Makefile))
include scripts/ansible-playbook.common-scripts/Makefile
else
# The first time the project is cloned, the submodules are empty.
# This will poplulate the submodule when 'make' is called
@no_targets__: git-init
endif

# Initialise the git login helper and initialise/update the submodules
git-init:
	git config --global credential.helper 'cache --timeout 7200'; \
	git submodule init; \
	git submodule update