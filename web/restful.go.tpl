package web

import (
	"net/http"

	"github.com/caiflower/common-tools/web"
	"github.com/caiflower/common-tools/web/router/controller"
	"{{ .MODULE }}/controller/v1/base"
	"{{ .MODULE }}/controller/v1/hobby"
	apihobby "{{ .MODULE }}/model/api/hobby"
)

func register(engine *web.Engine) {
	v1 := engine.Group("/v1")
	{
		helloController := &base.HelloWorldController{}
		v1.Get("/helloworld", helloController.SayHelloWorld)
		v1.Post("/req", helloController.DoRequest)
		v1.GRPC(http.MethodGet, "/hobby/search", apihobby._Hobby_Search_Handler, &hobby.HobbyImpl{})
	}
}
