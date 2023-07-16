package main

import (
	"github.com/ManavMuthanna/Flutter-Go-ToDoApp/backend/controller"
	"github.com/ManavMuthanna/Flutter-Go-ToDoApp/backend/initializers"
	"github.com/ManavMuthanna/Flutter-Go-ToDoApp/backend/migrate"
	"github.com/gin-gonic/gin"
)

func init() {
	initializers.LoadEnvVariables()
	initializers.ConnectToDB()
	migrate.MigrateDB()
}

func EnableCors() gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, PATCH, DELETE, OPTIONS")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(204)
			return
		}

		c.Next()
	}
}

func main() {
	router := gin.Default()

	// Add CORS middleware
	router.Use(EnableCors())
	router.GET("/api/hello", controller.Hello)

	//Add a Task
	router.POST("/api/create-task", controller.AddTask)
	//View all Tasks
	router.GET("/api/tasks", controller.ViewTasks)
	//Edit Task
	router.PATCH("/api/task/:id", controller.EditTask)
	//View a single Task
	router.GET("/api/task/:id", controller.ViewTaskDetails)
	//Delete a Task
	router.DELETE("/api/task/:id", controller.DeleteTask)

	router.Run("localhost:3000")
}
