package web

import (
	"github.com/caiflower/common-tools/global"
	"github.com/caiflower/common-tools/web"
	"github.com/caiflower/common-tools/web/app/server/config"
)

func Init() {
	engine := web.Default(
		config.WithAddr(":8081"),
		config.WithEnableSwagger(true),
	)

	register(engine)
	global.DefaultResourceManger.AddDaemon(engine)
}
