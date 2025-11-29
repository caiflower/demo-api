package main

import (
	"flag"
	"fmt"
	"os"
	"runtime"

	"github.com/caiflower/common-tools/cluster"
	dbv1 "github.com/caiflower/common-tools/db/v1"
	"github.com/caiflower/common-tools/global"
	"github.com/caiflower/common-tools/global/env"
	kafkav2 "github.com/caiflower/common-tools/kafka/v2"
	"github.com/caiflower/common-tools/pkg/bean"
	"github.com/caiflower/common-tools/pkg/http"
	"github.com/caiflower/common-tools/pkg/logger"
	redisv1 "github.com/caiflower/common-tools/redis/v1"
	webv1 "github.com/caiflower/common-tools/web/v1"
	"github.com/caiflower/demo-api/constants"
	"github.com/caiflower/demo-api/controller/v1/base"
	"github.com/caiflower/demo-api/dao"
	"github.com/caiflower/demo-api/service/caller"
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
	runtime.SetBlockProfileRate(1)
	runtime.SetMutexProfileFraction(1)

	// 限制 CPU 使用数量为 2 核
	runtime.GOMAXPROCS(2)

	// initConfig
	constants.InitConfig()
	// initLogger
	logger.InitLogger(&constants.DefaultConfig.LoggerConfig)
	global.DefaultResourceManger.Add(logger.DefaultLogger())
	// initDefaultWeb
	webv1.InitDefaultHttpServer(constants.DefaultConfig.WebConfig[0])

	addController()
	setBean()

	initDatabase()
	initRedis()
	initCluster()
	initWeb()

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
	consumerClient := kafkav2.NewConsumerClient(constants.DefaultConfig.KafkaConfig[0])
	consumerClient.Listen(func(message interface{}) {
		fmt.Println(message)
	})
	bean.AddBean(consumerClient)

	// init service
}

func initCluster() {
	if c, err := cluster.NewCluster(constants.DefaultConfig.ClusterConfig); err != nil {
		panic(fmt.Sprintf("Init cluster failed. %s", err.Error()))
	} else {
		tracker := cluster.NewDefaultJobTracker(constants.Prop.CallerInterval, &caller.DefaultCaller{})
		_ = c.AddJobTracker(tracker)
		global.DefaultResourceManger.AddDaemon(c)
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

func initRedis() {
	redisClient := redisv1.NewRedisClient(constants.DefaultConfig.RedisConfig[0])
	bean.AddBean(redisClient)
}

func initWeb() {
	global.DefaultResourceManger.AddDaemon(webv1.DefaultHttpServer)
}

func main() {
	// Signal
	global.DefaultResourceManger.Signal()
}
