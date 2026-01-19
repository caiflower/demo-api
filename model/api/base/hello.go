package base

import "github.com/caiflower/demo-api/model/api"

type DoRequestReq struct {
	api.Request
	ContentType string `header:"Content-Type"`
	Input       string `verf:"required"`
	Name        string `query:"name"`
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
