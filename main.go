package main

import (
	"flag"
	"fmt"
	"os"
	"runtime"

	"github.com/caiflower/common-tools/global"
	"github.com/caiflower/common-tools/global/env"
	"github.com/caiflower/common-tools/pkg/bean"
	"github.com/caiflower/common-tools/pkg/logger"
	"github.com/caiflower/common-tools/web/common/goai"
	"github.com/caiflower/common-tools/web/common/resp"
	"github.com/caiflower/demo-api/constants"
	"github.com/caiflower/demo-api/service/caller"
	"github.com/caiflower/demo-api/web"
)

func init() {
	var configPath string
	flag.StringVar(&configPath, "config", env.ConfigPath, "configure file!")
	flag.Usage = func() {
		_, _ = fmt.Fprintf(os.Stderr, "Usage: %s [-config <file_path>] \n", os.Args[0])
		flag.PrintDefaults()
	}
	flag.Parse()
	env.ConfigPath = configPath

	goai.Default().Config.CommonResponse = resp.Result{}
	goai.Default().Config.CommonResponseDataField = "data"

	runtime.GOMAXPROCS(4)

	// initConfig
	constants.InitConfig()
	// initLogger
	logger.InitLogger(&constants.DefaultConfig.LoggerConfig)
	global.DefaultResourceManger.Add(logger.DefaultLogger())

	initBean()

	web.Init()
	//dao.Init()
	caller.Init()

	// 依赖注入
	bean.Ioc()
}

func initBean() {

}

func main() {
	// Signal
	global.DefaultResourceManger.Signal()
}
