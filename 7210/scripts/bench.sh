#!/bin/bash -e

servers=(http://192.168.10.2:2379 http://192.168.10.4:2379 http://192.168.10.5:2379 http://192.168.10.6:2379 http://192.168.10.7:2379)
valuearray=(16 64 256)
currarray=(1 4 16 64 256)
totalrequests=4096

for keysize in ${valuearray[@]}; do
    for curr in ${currarray[@]}; do
        for i in ${servers[@]}; do
            echo write iter $j, concurrency $curr, key size $keysize, to server $i
            ./boom -m PUT -n $totalrequests -d value=`head -c $keysize < /dev/zero | tr '\0' '\141'` -c $curr -T application/x-www-form-urlencoded $i/v2/keys/oioioioioifghghghghghfghtyujujytfggggggggggfhyuoiutjgfyuiotrertf | grep -e "Average" -e "Requests/sec" -e "Latency" -e "95%" | tr "\n" "\t" | xargs echo
        done

        # put multiple requests at a time from different clients to all servers
        echo write iter $j, concurrency $curr, key size $keysize, to all servers
        for i in ${servers[@]}; do
            ./boom -m PUT -n $totalrequests -d value=`head -c $keysize < /dev/zero | tr '\0' '\141'` -c $curr -T application/x-www-form-urlencoded $i/v2/keys/oioioioioifghghghghghfghtyujujytfggggggggggfhyuoiutjgfyuiotrertf | grep -e "Average" -e "Requests/sec" -e "Latency" -e "95%" | tr "\n" "\t" | xargs echo &
        done

        # wait for all booms to finish
        for pid in $(pgrep 'boom'); do
            while kill -0 "$pid" 2> /dev/null; do
                sleep 1
            done
        done
    done
done
