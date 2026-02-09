package caller

import (
	"fmt"

	"github.com/caiflower/common-tools/cluster"
	"github.com/caiflower/common-tools/global"
	"{{ .MODULE }}/constants"
)

func Init() {
	if c, err := cluster.NewCluster(constants.DefaultConfig.ClusterConfig); err != nil {
		panic(fmt.Sprintf("Init cluster failed. %s", err.Error()))
	} else {
		tracker := cluster.NewDefaultJobTracker(constants.Prop.CallerInterval, &DefaultCaller{})
		_ = c.AddJobTracker(tracker)
		global.DefaultResourceManger.AddDaemon(c)
	}
}
