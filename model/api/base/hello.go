package base

import "github.com/caiflower/demo-api/model/api"

type DoRequestReq struct {
	api.Request
	Input string `verf:""`
}

type DoRequestRes struct {
	RequestId string
	Input     string
}
