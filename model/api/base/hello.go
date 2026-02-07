package base

import "github.com/caiflower/demo-api/model/api"

type DoRequestReq struct {
	api.Request
	ContentType string `header:"Content-Type" json:"-"`
	Input       string `verf:"required" json:"input"`
	Name        string `json:"name"`
}

type DoRequestRes struct {
	RequestId   string
	Input       string
	ContentType string
	Name        string
}

type RepeatRequest struct {
	Repeat int `path:"repeat"`
}
