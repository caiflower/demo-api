package base

import (
	"github.com/caiflower/common-tools/pkg/logger"
	"github.com/caiflower/common-tools/pkg/tools"
	"github.com/caiflower/common-tools/web/e"
	redisv1 "github.com/caiflower/common-tools/redis/v1"
	"{{ .MODULE }}/dao"
	"{{ .MODULE }}/model/api/base"
	"{{ .MODULE }}/model/bean"
)

type HelloWorldController struct {
	TestDao *dao.TestDao `autowrite:""`
	Redis   redisv1.RedisClient `autowrite:""`
}

func (c *HelloWorldController) SayHelloWorld() string {
	logger.Info("call SayHelloWorld")
	return "Hello World"
}

func (c *HelloWorldController) ReturnError() e.ApiError {
	logger.Error("call ReturnError")
	return e.NewApiError(e.InvalidArgument, "test apiError", nil)
}

func (c *HelloWorldController) DoRequest(req *base.DoRequestReq) (*base.DoRequestRes, e.ApiError) {
	logger.Info("DoRequest req: %v", tools.ToJson(req))
	if err := c.TestDao.BatchInsert([]*bean.Test{}); err != nil {
		return nil, e.NewApiError(e.Internal, err.Error(), err)
	}

	return &base.DoRequestRes{Input: req.Input, RequestId: req.RequestId}, nil
}

func (c *HelloWorldController) DoDao() (string, e.ApiError) {
	if err := c.TestDao.BatchInsert([]*bean.Test{}); err != nil {
		return "test", e.NewApiError(e.Internal, err.Error(), err)
	}

	return "test", nil
}
