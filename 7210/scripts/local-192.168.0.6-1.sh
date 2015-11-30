#!/bin/bash
if [[ $# -eq 0 ]]; then
  echo "usage ./start.sh type"
  echo "./start.sh 1 : etcd only"
  echo "./start.sh 2 : etcd + iperf"
  exit 1
fi

HOSTS=("192.168.0.2" "192.168.0.5" "192.168.0.4" "192.168.0.6" "192.168.0.7")
auth="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

j=0
icstr=""
for i in "${HOSTS[@]}"; do
    if [ $j -ne 0 ]; then
        icstr=$icstr",etcd$j=http://$i:2380"
    else
        icstr="etcd$j=http://$i:2380"
    fi
    ((j++))
done

binary=etcd3
hip=192.168.0.6
mount -t tmpfs -o size=300M none ~/etcd; chmod 777 etcd;
cd etcd; cp ../etcd0 etcd; chmod +x etcd; ./etcd -name $binary -data-dir ~/etcd/data_$binary/ -advertise-client-urls http://$hip:2379 -listen-client-urls http://0.0.0.0:2379 -initial-advertise-peer-urls http://$hip:2380 -listen-peer-urls http://0.0.0.0:2380 -initial-cluster-token etcd-cluster -initial-cluster $icstr -initial-cluster-state new &>/dev/null &

if [ $1 -ne 1 ]; then
    taskset -c 0 iperf -s &>/dev/null &
    # wait until all the servers are started
    read text
    for j in "${HOSTS[@]}"; do
        taskset -c 0 iperf -c $j -t 144000 &>/dev/null &
    done
fi
