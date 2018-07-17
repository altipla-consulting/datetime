
FILES = $(shell find . -type f -name '*.go' -not -path './vendor/*')

gofmt:
	@gofmt -w $(FILES)
	@gofmt -r '&α{} -> new(α)' -w $(FILES)

deps:
	go get -u github.com/mgechev/revive

	go get -u github.com/golang/protobuf/proto

test:
	revive -formatter friendly ./...
	go install .

protos:
	actools protoc --go_out=. ./protos/datetime/datetime.proto
