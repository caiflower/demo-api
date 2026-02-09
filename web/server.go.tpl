package web

import (
	"github.com/caiflower/common-tools/global"
	"github.com/caiflower/common-tools/web"
	"github.com/caiflower/common-tools/web/app/server/config"
	"{{ .MODULE }}/constants"
)

func Init() {
	cfg := constants.DefaultConfig.WebConfig[0]
	engine := web.Default(
		config.WithAddr(cfg.Addr),
		config.WithEnableSwagger(cfg.EnableSwagger),
		config.WithEnablePprof(cfg.EnablePprof),
	)

	register(engine)
	global.DefaultResourceManger.AddDaemon(engine)
}
