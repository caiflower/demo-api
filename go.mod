module github.com/caiflower/demo-api

go 1.16

//github.com/caiflower/common-tools v0.0.0-20241122144522-c2375f3ca330 => ../common-tools
replace github.com/json-iterator/go v1.1.12 => github.com/caiflower/json-iterator v1.1.12

require (
	github.com/caiflower/common-tools v0.0.0-20250915061606-dfbf797fbf67
	github.com/confluentinc/confluent-kafka-go/v2 v2.0.2
)
