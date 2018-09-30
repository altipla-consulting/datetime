
FILES = $(shell find . -type f -name '*.go' -not -path './vendor/*')

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
	actools protoc --go_out=tmp ./altipla/datetime/datetime.proto
	rm -f altipla/datetime/datetime.pb.go
	mv tmp/github.com/altipla-consulting/datetime/altipla/datetime/datetime.pb.go altipla/datetime/
	rm -rf tmp
