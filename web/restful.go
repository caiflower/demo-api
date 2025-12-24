package web

import (
	"net/http"

	. "github.com/caiflower/common-tools/web"
	. "github.com/caiflower/common-tools/web/router/controller"
	"github.com/caiflower/demo-api/controller/v1/base"
)

func register(engine *Engine) {
	engine.AddController(&base.HelloWorldController{})
	group := NewRestFul().Version("v1").Controller("base.HelloWorldController")
	engine.Register(group.Method(http.MethodGet).Path("/helloworld").Action("SayHelloWorld"))
	engine.Register(group.Method(http.MethodGet).Path("/error").Action("ReturnError"))
	engine.Register(group.Method(http.MethodPost).Path("/req").Action("DoRequest"))
	engine.Register(group.Method(http.MethodGet).Path("/repeat/:repeat").Action("Repeat"))
}
