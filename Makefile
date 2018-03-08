
FILES = $(shell find . -not -path "*vendor*" -not -path "*node_modules*" -type f -name '*.go')

.PHONY: protos

gofmt:
	@gofmt -w $(FILES)
	@gofmt -r '&α{} -> new(α)' -w $(FILES)

protos:
	actools protoc --go_out=. ./protos/datetime/datetime.proto
