
FILES = $(shell find . -type f -name '*.go' -not -path './vendor/*')

.PHONY: protos

gofmt:
	@gofmt -w $(FILES)
	@gofmt -r '&α{} -> new(α)' -w $(FILES)

deps:
	go get -u github.com/mgechev/revive

test:
	revive -formatter friendly ./...
	go install .
	go test ./...

protos:
	mkdir -p tmp
	actools protoc --go_out=tmp ./protos/datetime/datetime.proto
	rm -f protos/datetime/datetime.pb.go
	mv tmp/github.com/altipla-consulting/datetime/protos/datetime/datetime.pb.go protos/datetime/
	rm -rf tmp
