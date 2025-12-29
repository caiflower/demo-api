package hobby

//go:generate protoc --go_out=../api/hobby --go_opt=paths=source_relative --go-grpc_out=../api/hobby --go-grpc_opt=paths=source_relative ./hobby.proto
//go:generate protoc-go-inject-tag -input ../api/hobby/hobby.pb.go
