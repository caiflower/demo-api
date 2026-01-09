package web

import (
	"net/http"

	. "github.com/caiflower/common-tools/web"
	. "github.com/caiflower/common-tools/web/router/controller"
	"github.com/caiflower/demo-api/controller/v1/base"
	"github.com/caiflower/demo-api/controller/v1/hobby"
	apihobby "github.com/caiflower/demo-api/model/api/hobby"
)

func register(engine *Engine) {

	v1 := NewRestFul().Group("/v1")
	{
		helloController := engine.AddController(&base.HelloWorldController{})
		engine.Register(v1.Method(http.MethodGet).Path("/helloworld").RegisterMethod(helloController.GetMethod("SayHelloWorld")))
		engine.Register(v1.Method(http.MethodGet).Path("/error").RegisterMethod(helloController.GetMethod("ReturnError")))
		engine.Register(v1.Method(http.MethodPost).Path("/req").RegisterMethod(helloController.GetMethod("DoRequest")))
		engine.Register(v1.Method(http.MethodGet).Path("/repeat/:repeat").RegisterMethod(helloController.GetMethod("Repeat")))
	}

	{
		hobbyController := engine.RegisterGRPCService(&apihobby.Hobby_ServiceDesc, &hobby.HobbyImpl{})
		engine.Register(v1.Method(http.MethodGet).Path("/hobby").RegisterMethod(hobbyController.GetMethod("Search3")))
		engine.Register(v1.Method(http.MethodGet).Path("/hobby/search").RegisterGrpcMethod(hobbyController.GetGrpcMethodDesc("Search")))
	}
}
