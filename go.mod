module github.com/caiflower/demo-api

go 1.16

replace (
	github.com/caiflower/common-tools v0.0.0-20241122144522-c2375f3ca330 => ../common-tools
	github.com/json-iterator/go v1.1.12 => github.com/caiflower/json-iterator v1.1.12
)

require github.com/caiflower/common-tools v0.0.0-20241122144522-c2375f3ca330
