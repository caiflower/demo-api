package caller

import "github.com/caiflower/common-tools/pkg/logger"

type DefaultCaller struct {
}

func (c *DefaultCaller) MasterCall() {
	logger.Info("MasterCall")
}

func (c *DefaultCaller) SlaverCall(leaderName string) {
	logger.Info("SlaverCall leaderName=%v", leaderName)
}
