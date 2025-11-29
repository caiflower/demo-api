package main

import (
	"fmt"

	"github.com/caiflower/common-tools/cluster"
	dbv1 "github.com/caiflower/common-tools/db/v1"
	"github.com/caiflower/common-tools/global"
	kafkav2 "github.com/caiflower/common-tools/kafka/v2"
	"github.com/caiflower/common-tools/pkg/bean"
	"github.com/caiflower/common-tools/pkg/http"
	"github.com/caiflower/common-tools/pkg/logger"
	"github.com/caiflower/common-tools/redis/v1"
	"github.com/caiflower/common-tools/web/v1"
	"{{ .MODULE }}/constants"
	"{{ .MODULE }}/controller/v1/base"
	"{{ .MODULE }}/dao"
	"{{ .MODULE }}/service/caller"
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
	initRedis()
	initKafka()
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

	// init service
}

func initCluster() {
	if c, err := cluster.NewCluster(constants.DefaultConfig.ClusterConfig); err != nil {
		panic(fmt.Sprintf("Init cluster failed. %s", err.Error()))
	} else {
        bean.AddBean(c)
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

func initKafka() {
	// v1 和 v2版本的区别是底层依赖的kafka客户端包不一样
	// v1 基于github.com/confluentinc/confluent-kafka-go，依赖cgo，动态编译
	// v2 基于github.com/Shopify/sarama
	consumer := kafkav2.NewConsumerClient(constants.DefaultConfig.KafkaConfig[0])
	bean.SetBean("consumer", consumer)

	producer := kafkav2.NewProducerClient(constants.DefaultConfig.KafkaConfig[0])
	bean.SetBean("producer", producer)
}

func initWeb() {
	global.DefaultResourceManger.AddDaemon(webv1.DefaultHttpServer)
}

func main() {
	// Start And Signal
	global.DefaultResourceManger.Signal()
}
