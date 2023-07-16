package controller

import (
	"errors"
	"net/http"

	"github.com/ManavMuthanna/Flutter-Go-ToDoApp/backend/initializers"
	"github.com/ManavMuthanna/Flutter-Go-ToDoApp/backend/model"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func Hello(context *gin.Context) {
	context.IndentedJSON(http.StatusOK, gin.H{"response": "Hello from Backend!"})
}

func AddTask(context *gin.Context) {
	//Request
	var body struct {
		TaskName   string
		TaskDetail string
	}

	context.Bind(&body)

	//Create a Task
	task := model.Task{TaskName: body.TaskName, TaskDetail: body.TaskDetail}
	result := initializers.DB.Create(&task)

	if result.Error != nil {
		context.Status(400)
		return
	}

	//Return
	context.IndentedJSON(http.StatusOK, gin.H{
		"task": task,
	})
}

func ViewTasks(context *gin.Context) {
	var tasks []model.Task
	initializers.DB.Find(&tasks)
	//Respond with them
	context.IndentedJSON(http.StatusOK, tasks)
}

func ViewTaskDetails(context *gin.Context) {
	id := context.Param("id")

	var task model.Task
	result := initializers.DB.First(&task, id)

	if errors.Is(result.Error, gorm.ErrRecordNotFound) {
		context.Status(http.StatusNotFound)
		return
	} else if result.Error != nil {
		context.Status(http.StatusInternalServerError)
		return
	}

	// Respond with the task
	context.JSON(http.StatusOK, task)
}

func EditTask(context *gin.Context) {
	//Get the id off the url
	id := context.Param("id")

	//Get the data off req body
	var body struct {
		TaskName   string
		TaskDetail string
	}

	context.Bind(&body)

	//Find the post to update
	var task model.Task
	initializers.DB.First(&task, id)

	//update it
	initializers.DB.Model(&task).Updates(model.Task{TaskName: body.TaskName, TaskDetail: body.TaskDetail})

	//respond
	context.IndentedJSON(http.StatusOK, task)
}

func DeleteTask(context *gin.Context) {
	id := context.Param("id")

	var task []model.Task
	result := initializers.DB.Delete(&task, id)

	if result.Error != nil {
		context.Status(404)
		return
	}
	//Respond with them
	context.IndentedJSON(http.StatusOK, "Deleted!")
}
