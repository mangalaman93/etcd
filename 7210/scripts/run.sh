#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "usage ./start.sh type"
    echo "./start.sh 1 : etcd only"
    echo "./start.sh 2 : etcd + iperf"
    exit 1
fi

HOSTS=("192.168.0.2" "192.168.0.5" "192.168.0.4" "192.168.0.6" "192.168.0.7")
auth="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

./bench.sh >> "results_exp$1.txt"
sleep $1

for i in "${HOSTS[@]}"; do
    scp $auth -i etcd root@"$i":~/logs.txt $PWD/logs-"$i"-$1.txt
done

for i in "${HOSTS[@]}"; do
  ssh $auth -i etcd root@"$i" "killall iperf; kill \`pidof $etcdbin\`;"
done
