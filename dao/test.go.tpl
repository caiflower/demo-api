package dao

import (
	dbv1 "github.com/caiflower/common-tools/db/v1"
	"{{ .MODULE }}/model/bean"
)

type TestDao struct {
	DB dbv1.IDB `autowrite:""`
}

func (d *TestDao) BatchInsert(dao []*bean.Test) error {
	// do something
	return nil
}
