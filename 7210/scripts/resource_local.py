#!/usr/bin/env python

import os
import sys
import tempfile
import time
import subprocess

USAGE_CHECK_PERIOD = 4

def system_cmd(cmd):
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    # if only the command executed successfully
    if p.wait() == 0:
      return p.stdout.readlines()
    else:
      raise Exception("error!")

def cpu():
    l = file('/proc/stat').readline().split()
    return sum(map(float, l[1:4]+l[6:8]))

def net(col):
    if col == 2:
        return int(file('/sys/devices/virtual/net/eth0.11/statistics/rx_bytes').read())
    else:
        return int(file('/sys/devices/virtual/net/eth0.11/statistics/tx_bytes').read())

def mem():
    return subprocess.check_output("free -m | grep buffers/ | awk '{{print $3}}'", shell=True)

def main():
    cpu_prev = cpu()
    rx_prev = net(2)
    tx_prev = net(10)
    
    logfile = open("logs.txt", 'w')
    logfile.truncate()

    try:
        while True:
            time.sleep(USAGE_CHECK_PERIOD)
            # CPU
            new = cpu()
            logfile.write(str((new-cpu_prev)/USAGE_CHECK_PERIOD))
            logfile.write("\t")
            cpu_prev = new
            # RX
            new = net(2)
            logfile.write(str((new-rx_prev)/USAGE_CHECK_PERIOD))
            logfile.write("\t")
            rx_prev = new
            # TX
            new = net(10)
            logfile.write(str((new-tx_prev)/USAGE_CHECK_PERIOD))
            logfile.write("\t"+mem()) 
            tx_prev = new
    except:
        pass

if __name__ == '__main__':
    main()
