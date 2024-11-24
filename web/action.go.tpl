package web

import (
	. "github.com/caiflower/common-tools/web/v1"
	"{{ .MODULE }}/controller/v1/base"
)

func addController() {
	AddController(&base.HelloWorldController{})
}
