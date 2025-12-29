package web

import (
	"net/http"

	. "github.com/caiflower/common-tools/web"
	. "github.com/caiflower/common-tools/web/router/controller"
	"github.com/caiflower/demo-api/controller/v1/base"
)

func register(engine *Engine) {
	helloController := engine.AddController(&base.HelloWorldController{})
	v1 := NewRestFul().Group("/v1")
	{
		engine.Register(v1.Method(http.MethodGet).Path("/helloworld").RegisterMethod(helloController.GetMethod("SayHelloWorld")))
		engine.Register(v1.Method(http.MethodGet).Path("/error").RegisterMethod(helloController.GetMethod("ReturnError")))
		engine.Register(v1.Method(http.MethodPost).Path("/req").RegisterMethod(helloController.GetMethod("DoRequest")))
		engine.Register(v1.Method(http.MethodGet).Path("/repeat/:repeat").RegisterMethod(helloController.GetMethod("Repeat")))
	}
}
