package constants

import (
	"github.com/caiflower/common-tools/global/config"
)

var DefaultConfig = config.DefaultConfig{}
var Prop = Config{}

func InitConfig() {
	if err := config.LoadDefaultConfig(&DefaultConfig); err != nil {
		panic(err)
	}
	if err := config.LoadYamlFile("config.yaml.tpl", &Prop); err != nil {
		panic(err)
	}
}

type Config struct {
	GOMAXPROCS     int `yaml:"go_max_procs"`
	CallerInterval int `yaml:"caller_interval"`
}
