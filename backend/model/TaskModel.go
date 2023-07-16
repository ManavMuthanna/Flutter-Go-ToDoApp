package model

type Task struct {
	ID         int32 `gorm:"primaryKey;autoIncrement"`
	TaskName   string
	TaskDetail string
	Created    int64 `gorm:"autoCreateTime:nano"`
}
