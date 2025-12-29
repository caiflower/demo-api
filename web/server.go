package web

import (
	"github.com/caiflower/common-tools/global"
	"github.com/caiflower/common-tools/web"
	"github.com/caiflower/common-tools/web/server/config"
)

func Init() {
	engine := web.Default(
		config.WithAddr(":8081"),
		config.WithEnablePprof(true),
	)

	register(engine)
	global.DefaultResourceManger.AddDaemon(engine)

	engine1 := web.Default(
		config.WithMode(config.ServerModeStandard))
	register(engine1)
	global.DefaultResourceManger.AddDaemon(engine1)

	go Hertz()
}
