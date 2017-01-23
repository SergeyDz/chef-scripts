knife ssh 'name:sdzyuban-mesos-*' -x vagrant -P vagrant 'rm /etc/chef/client.pem'
yes | knife node bulk delete 'sdzyuban-mesos(.*)' && yes | knife client bulk delete 'sdzyuban-mesos(.*)' 

knife bootstrap 10.1.1.231 --ssh-user vagrant --ssh-password 'vagrant' --sudo --use-sudo-password --node-name sdzyuban-mesos-01 --run-list 'role[hadoop-hdfs-namenode],role[hadoo-hdfs-datanode],role[hadoop-yarn]' &/
knife bootstrap 10.1.1.232 --ssh-user vagrant --ssh-password 'vagrant' --sudo --use-sudo-password --node-name sdzyuban-mesos-02 --run-list 'role[hadoo-hdfs-namenode],role[hadoop-hdfs-datanode],role[hadoop-yarn]' &/
knife bootstrap 10.1.1.233 --ssh-user vagrant --ssh-password 'vagrant' --sudo --use-sudo-password --node-name sdzyuban-mesos-03 --run-list 'role[hadoo-hdfs-namenode],role[hadoop-hdfs-datanode],role[hadoop-yarn]'


