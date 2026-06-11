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
		v1.GET("/helloworld", helloController.SayHelloWorld)
		v1.POST("/req", helloController.DoRequest)
		v1.GRPC(http.MethodGet, "/hobby/search", apihobby.Hobby_ServiceDesc.Methods[0].Handler, &hobby.HobbyImpl{})
	}
}
