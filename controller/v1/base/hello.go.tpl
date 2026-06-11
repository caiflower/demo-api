package base

import (
	"github.com/caiflower/common-tools/web/common/e"
	"{{ .MODULE }}/model/api/base"
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

func (c *HelloWorldController) DoRequest(req *base.DoRequestReq) (*base.DoRequestRes, e.ApiError) {
	return &base.DoRequestRes{
		RequestId:   req.RequestId,
		Input:       req.Input,
		ContentType: req.ContentType,
		Name:        req.Name,
	}, nil
}
