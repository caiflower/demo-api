module {{ .MODULE }}

go 1.16

replace (
	github.com/json-iterator/go v1.1.12 => github.com/caiflower/json-iterator v1.1.12
)

require github.com/caiflower/common-tools v0.0.0-20241123160113-b208b070e167
