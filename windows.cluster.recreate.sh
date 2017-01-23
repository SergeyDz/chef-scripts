#/bin/bash

# delete all nodes 
yes | knife node bulk delete '(.*)-pc' && yes | knife client bulk delete '(.*)-pc'

knife winrm "0483-pc.fg.local" "powershell.exe Remove-Item c:\\chef\\client.pem -Force -Recurse" -m -x fg\\sdzyuban -P $1  &\
knife winrm "sdzyuban-pc.fg.local" "powershell.exe Remove-Item c:\\chef\\client.pem -Force -Recurse" -m -x fg\\sdzyuban -P $1


# create unsecured roles
knife bootstrap windows winrm 0483-pc -N 0483-pc -x fg\\sdzyuban -P $1 --run-list 'role[hostfile]' &\
knife bootstrap windows winrm sdzyuban-pc -N sdzyuban-pc -x fg\\sdzyuban -P $1 --run-list 'role[hostfile]' --json-attributes '{"vagrant": { "local" : { "path" : "D:/Storage/VirtualBox/Marathon"} }}'

knife vault refresh passwords chef
knife vault rotate keys passwords chef --clean-unknown-clients

cd /var/chef/data_bags/passwords
knife data bag from file passwords chef.json
knife data bag from file passwords chef_keys.json


# add node roles
knife node run_list add 0483-pc 'role[winrm]' 
knife node run_list add sdzyuban-pc 'role[winrm]' 

# run the winrm roles 
knife winrm "0483-pc" "chef-client -c c:/chef/client.rb" -m -x fg\\sdzyuban -P $1  &\
knife winrm "sdzyuban-pc" "chef-client -c c:/chef/client.rb" -m -x fg\\sdzyuban -P $1
