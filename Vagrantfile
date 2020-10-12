# Load the shared configuration
require 'json'
json_file = File.open "clusterDetails.json"
clusterDetails = JSON.load(json_file)

require_relative 'scripts/ansible-playbook.common-scripts/Vagrantfile'

# String.to_boolean has been loaded from Vagrantfile
# These environment variables are set by the Makefile.
env_name = ENV["env_name"]
profile = ENV["profile"]
ansible_tags = ENV["ansible_tags"]
debug = ENV["debug"]
fullBuild = ENV["FULL_BUILD"].to_boolean
vagrantCommand = ARGV[0]

# Call function defined in scripts/ansible-playbook.common-scripts/Vagrantfile
createCluster(clusterDetails, env_name, debug, fullBuild, vagrantCommand, profile, ansible_tags)