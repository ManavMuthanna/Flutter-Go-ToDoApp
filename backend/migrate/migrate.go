package migrate

import (
	"github.com/ManavMuthanna/Flutter-Go-ToDoApp/backend/initializers"
	"github.com/ManavMuthanna/Flutter-Go-ToDoApp/backend/model"
)

func init() {
	initializers.LoadEnvVariables()
	initializers.ConnectToDB()
}

func MigrateDB() {
	initializers.DB.AutoMigrate(&model.Task{})
}
