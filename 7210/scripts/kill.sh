#!/bin/bash

HOSTS=("192.168.0.2" "192.168.0.4" "192.168.0.5" "192.168.0.6" "192.168.0.7")
auth="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

for i in "${HOSTS[@]}"
do
	ssh $auth -i etcd root@"$i" "killall iperf; kill \`pidof etcd\`;"
done
