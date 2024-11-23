package web

import (
	. "github.com/caiflower/common-tools/web/v1"
	"github.com/caiflower/demo-api/controller/v1/base"
)

func addController() {
	AddController(&base.HelloWorldController{})
}
