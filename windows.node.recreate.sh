#/bin/bash

# delete all nodes 
yes | knife node bulk delete 'sdzyuban-(.*)' && yes | knife client bulk delete 'sdzyuban-(.*)'

#knife winrm "$2" "powershell.exe Remove-Item c:\\chef\\client.pem -Force -Recurse" -m -x fg\\sdzyuban -P $1

# create unsecured roles
knife bootstrap windows winrm $2 -N $2 -x fg\\sdzyuban -P $1 --run-list 'role[hostfile]' 

knife vault refresh passwords chef
knife vault rotate keys passwords chef --clean-unknown-clients

cd /var/chef/data_bags/passwords
knife data bag from file passwords chef.json
knife data bag from file passwords chef_keys.json

# add node roles
knife node run_list add $2 'role[winrm]' 

# run the winrm roles 
knife winrm "$2" "chef-client -c c:/chef/client.rb" -m -x fg\\sdzyuban -P $1