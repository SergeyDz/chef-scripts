# add node roles
knife node run_list add sdzyuban-mesos-01 'role[hadoop-hdfs-namenode],role[hadoop-yarn],role[hadoop-hive],role[hadoop-pig]' &\
knife node run_list add sdzyuban-mesos-02 'role[hadoop-hdfs-datanode],role[hadoop-yarn],role[hadoop-hive],role[hadoop-pig]' &\
knife node run_list add sdzyuban-mesos-03 'role[hadoop-hdfs-datanode],role[hadoop-yarn],role[hadoop-hive],role[hadoop-pig]'

# run the hadoop roles
knife ssh "name:sdzyuban-mesos-01" "sudo chef-client" -x vagrant -P vagrant &\
knife ssh "name:sdzyuban-mesos-02" "sudo chef-client" -x vagrant -P vagrant &\
knife ssh "name:sdzyuban-mesos-03" "sudo chef-client" -x vagrant -P vagrant
