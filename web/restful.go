package web

import (
	"net/http"

	. "github.com/caiflower/common-tools/web/v1"
)

func register() {
	Register(NewRestFul().Method(http.MethodGet).Version("v1").Controller("base.HelloWorldController").Path("/helloworld").Action("SayHelloWorld"))
	Register(NewRestFul().Method(http.MethodGet).Version("v1").Controller("base.HelloWorldController").Path("/error").Action("ReturnError"))
	Register(NewRestFul().Method(http.MethodPost).Version("v1").Controller("base.HelloWorldController").Path("/req").Action("DoRequest"))
}
