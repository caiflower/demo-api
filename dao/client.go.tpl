package dao

import (
	"fmt"

	dbv1 "github.com/caiflower/common-tools/db/v1"
	"github.com/caiflower/common-tools/pkg/bean"
	"{{ .MODULE }}/constants"
)

func Init() {
	db, err := dbv1.NewDBClient(constants.DefaultConfig.DatabaseConfig[0])
	if err != nil {
		panic(fmt.Sprintf("Init database failed. %s", err.Error()))
	}
	bean.AddBean(db)
}

// Auto-generate DAO layer: configure database, tables and auth info
//go:generate go run -mod=mod github.com/caiflower/common-tools/db/v1/cmd@release-v0.1.0 -dsn "mysql:root:admin@tcp(10.226.138.71:3306)/jvirt-jcs" -pkg "{{ .MODULE }}/dao" -tables instance,network -dao_out .
