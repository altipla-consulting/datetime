package datetime

import (
	"time"

	pbdatetime "github.com/altipla-consulting/datetime/protos/datetime"
	"github.com/golang/protobuf/ptypes"
	pbtimestamp "github.com/golang/protobuf/ptypes/timestamp"
)

const ISO8601 = "2006-01-02"

func DiffDays(a, b time.Time) int64 {
	diff := b.Sub(a)

	if diff < 0 {
		return int64((diff - 12*time.Hour) / (24 * time.Hour))
	}

	return int64((diff + 12*time.Hour) / (24 * time.Hour))
}

func TimeToDate(t time.Time) time.Time {
	year, month, day := t.Date()

	return time.Date(year, month, day, 0, 0, 0, 0, time.UTC)
}

func SerializeDate(t time.Time) *pbdatetime.Date {
	if t.IsZero() {
		return nil
	}

	year, month, day := t.Date()

	return &pbdatetime.Date{
		Day:   int32(day),
		Month: int32(month),
		Year:  int32(year),
	}
}

func ParseDate(date *pbdatetime.Date) time.Time {
	if date == nil {
		return time.Time{}
	}
	return time.Date(int(date.Year), time.Month(date.Month), int(date.Day), 0, 0, 0, 0, time.UTC)
}

func SerializeTimestamp(t time.Time) *pbtimestamp.Timestamp {
	result, err := ptypes.TimestampProto(t)
	if err != nil {
		panic(err)
	}

	return result
}

func ParseTimestamp(timestamp *pbtimestamp.Timestamp) time.Time {
	t, err := ptypes.Timestamp(timestamp)
	if err != nil {
		panic(err)
	}

	return t
}
