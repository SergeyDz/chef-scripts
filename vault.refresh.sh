knife vault refresh passwords chef
knife vault rotate keys passwords chef --clean-unknown-clients

cd /var/chef/data_bags/passwords
knife data bag from file passwords chef.json
knife data bag from file passwords chef_keys.json

