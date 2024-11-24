package main

import (
	"fmt"

	"github.com/caiflower/common-tools/cluster"
	dbv1 "github.com/caiflower/common-tools/db/v1"
	"github.com/caiflower/common-tools/global"
	"github.com/caiflower/common-tools/pkg/bean"
	"github.com/caiflower/common-tools/pkg/http"
	"github.com/caiflower/common-tools/pkg/logger"
	webv1 "github.com/caiflower/common-tools/web/v1"
	"{{ .MODULE }}/constants"
	"{{ .MODULE }}/controller/v1/base"
	"{{ .MODULE }}/dao"
	"{{ .MODULE }}/service/caller"
	"{{ .MODULE }}/web"
)

func init() {
	// initConfig
	constants.InitConfig()
	// initLogger
	logger.InitLogger(&constants.DefaultConfig.LoggerConfig)
	// initDefaultWeb
	webv1.InitDefaultHttpServer(constants.DefaultConfig.WebConfig[0])

	addController()
	setBean()

	initDatabase()
	initCluster()

	// 依赖注入
	bean.Ioc()
}

func addController() {
	webv1.AddController(&base.HelloWorldController{})
}

func setBean() {
	client := http.NewHttpClient(constants.DefaultConfig.HttpClientConfig)
	bean.AddBean(client)

	// init dao
	bean.AddBean(&dao.TestDao{})

	// init service
}

func initCluster() {
	if c, err := cluster.NewCluster(constants.DefaultConfig.ClusterConfig); err != nil {
		panic(fmt.Sprintf("Init cluster failed. %s", err.Error()))
	} else {
		tracker := cluster.NewDefaultJobTracker(constants.Prop.CallerInterval, c, &caller.DefaultCaller{})
		tracker.Start()
		c.StartUp()
	}
}

func initDatabase() {
	// initDatabase
	db, err := dbv1.NewDBClient(constants.DefaultConfig.DatabaseConfig[0])
	if err != nil {
		panic(fmt.Sprintf("Init database failed. %s", err.Error()))
	}
	bean.AddBean(db)
}

func main() {
	// webserver
	web.StartUp()
	// Signal
	global.DefaultResourceManger.Signal()
}
