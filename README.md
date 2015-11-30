etcd
=====
Checkout original [README](https://github.com/coreos/etcd/blob/master/README.md)

This project is a fork of original etcd repository from coreos. We have made changes in etcd
along with changes in Golang http library (see [here](https://github.com/mangalaman93/http-prio))
in order to set application level priorities to various messages sent over the network. Please
find the report [here](https://github.com/mangalaman93/etcd/blob/cs7210/7210/report.pdf).

Evaluation Setup
================
The results are evaluated on a topology of Banana Pi boards attached to a 802.1p enabled switch
making a star like topology.

Evaluation Results
==================
* raw data [here](https://docs.google.com/spreadsheets/d/1UcozyDJjcuiJSWYn7EgtsZ8J-0pEBYQPm-aRAf2SCjI)
* Final chosen graphs [here](https://docs.google.com/spreadsheets/d/1mqlFHtT4Fv99gQYT6qC-XC-Z52KAeL1C1w-LQb8JK5o)
