package web

import (
	. "github.com/caiflower/common-tools/web/v1"
)

func StartUp() {
	// register
	register()

	DefaultHttpServer.StartUp()
}
