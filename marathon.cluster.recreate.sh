knife ssh 'name:sdzyuban-mesos-*' -x vagrant -P vagrant 'rm /etc/chef/client.pem'
yes | knife node bulk delete 'sdzyuban-mesos(.*)' && yes | knife client bulk delete 'sdzyuban-mesos(.*)' 

#until ping -c1 10.1.1.231 &>/dev/null; do :; done
knife bootstrap 10.1.1.231 --ssh-user vagrant --ssh-password 'vagrant' --sudo --use-sudo-password --node-name sdzyuban-mesos-01 --run-list 'role[zookeeper], role[mesos-master], role[mesos-slave], role[marathon], role[mesosphere], role[docker]' 
knife bootstrap 10.1.1.232 --ssh-user vagrant --ssh-password 'vagrant' --sudo --use-sudo-password --node-name sdzyuban-mesos-02 --run-list 'role[zookeeper], role[mesos-master], role[mesos-slave], role[marathon], role[mesosphere], role[docker]' 
knife bootstrap 10.1.1.233 --ssh-user vagrant --ssh-password 'vagrant' --sudo --use-sudo-password --node-name sdzyuban-mesos-03 --run-list 'role[zookeeper], role[mesos-master], role[mesos-slave], role[marathon], role[mesosphere], role[docker]' 
#knife bootstrap 10.1.1.234 --ssh-user vagrant --ssh-password 'vagrant' --sudo --use-sudo-password --node-name sdzyuban-mesos-04 --run-list 'role[mesos-slave], role[mesosphere], role[docker]'  
#knife bootstrap 10.1.1.235 --ssh-user vagrant --ssh-password 'vagrant' --sudo --use-sudo-password --node-name sdzyuban-mesos-05 --run-list 'role[mesos-slave], role[mesosphere], role[docker]'  
#knife bootstrap 10.1.1.236 --ssh-user vagrant --ssh-password 'vagrant' --sudo --use-sudo-password --node-name sdzyuban-mesos-06 --run-list 'role[mesos-slave], role[mesosphere], role[docker]'

