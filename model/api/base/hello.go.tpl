package base

import "{{ .MODULE }}/model/api"

type DoRequestReq struct {
	api.Request
	Input string `verf:""`
}

type DoRequestRes struct {
	RequestId string
	Input     string
}
