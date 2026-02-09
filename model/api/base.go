package api

type Request struct {
	RequestId string `header:"X-Request-Id" json:"-"`
}
