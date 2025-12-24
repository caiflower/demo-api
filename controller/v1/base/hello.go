package base

import (
	"strings"

	"github.com/caiflower/common-tools/pkg/logger"
	"github.com/caiflower/common-tools/web/common/e"
	"github.com/caiflower/demo-api/model/api/base"
)

type HelloWorldController struct {
	//TestDao *dao.TestDao        `autowired:""`
	//Redis   redisv1.RedisClient `autowired:""`
	//Consumer xkafka.Consumer     `autowired:"consumer"`
	//Producer xkafka.Producer     `autowired:"producer"`
}

func (c *HelloWorldController) SayHelloWorld() string {
	//logger.Info("call SayHelloWorld")
	return "Hello World"
}

func (c *HelloWorldController) ReturnError() e.ApiError {
	logger.Info("test")
	return e.NewApiError(e.InvalidArgument, "test apiError", nil)
}

func (c *HelloWorldController) Repeat(req *base.RepeatRequest) string {
	return strings.Repeat("1", req.Repeat)
}

func (c *HelloWorldController) DoRequest(req *base.DoRequestReq) (*base.DoRequestRes, e.ApiError) {
	return &base.DoRequestRes{
		RequestId:   req.RequestId,
		Input:       req.Input,
		ContentType: req.ContentType,
		Name:        req.Name,
	}, nil
}
