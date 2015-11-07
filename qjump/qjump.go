package qjump

import (
	pb "github.com/coreos/etcd/raft/raftpb"
)

const (
	// version request message
	QJ_VERSION_PRIORITY = 1

	// request to find members
	QJ_MEMBERS_PRIORITY = 1

	// probing for status of follower
	QJ_PROBING_PRIORITY = 1

	// TODO:?
	QJ_STREAM_PRIORITY = 1

	// proposal message (whenever a quorum is required)
	QJ_MSGPROP_PRIORITY = 1

	// start a new election term
	QJ_MSGHUP_PRIORITY = 1

	// leader to follower heartbeats
	QJ_MSGHEARTBEAT_PRIORITY = 1

	// if some node goes down
	QJ_MSGUNRECHABLE_PRIORITY = 1

	// snapshot related messages
	QJ_MSGSNAP_PRIORITY = 1

	// consensus messages
	QJ_MSGAPP_PRIORITY     = 1
	QJ_MSGAPPVOTE_PRIORITY = 1
)

func GetPriority(m pb.Message) int {
	switch m.Type {
	case pb.MsgHup:
		return QJ_MSGHUP_PRIORITY
	case pb.MsgProp:
		return QJ_MSGPROP_PRIORITY
	case pb.MsgApp:
	case pb.MsgAppResp:
		return QJ_MSGAPP_PRIORITY
	case pb.MsgVote:
	case pb.MsgVoteResp:
		return QJ_MSGAPPVOTE_PRIORITY
	case pb.MsgSnap:
	case pb.MsgSnapStatus:
		return QJ_MSGSNAP_PRIORITY
	case pb.MsgHeartbeat:
	case pb.MsgHeartbeatResp:
		return QJ_MSGHEARTBEAT_PRIORITY
	case pb.MsgUnreachable:
		return QJ_MSGUNRECHABLE_PRIORITY
	default:
	}

	panic(m.Type)
}
