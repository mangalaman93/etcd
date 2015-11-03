package qjump

import (
	pb "github.com/coreos/etcd/raft/raftpb"
)

const (
	QJ_VERSION_PRIORITY = 1
	QJ_MEMBERS_PRIORITY = 1
	QJ_PROBING_PRIORITY = 1
	QJ_STREAM_PRIORITY  = 1
)

func GetPriority(m pb.Message) int {
	return 1
}
