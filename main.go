package main

import (
	"github.com/gin-gonic/gin"
)

func main() {

	router := gin.Default()

	router.GET("/hello", func(c *gin.Context) {
		c.IndentedJSON(200, gin.H{
			"message": "hello",
		})
	})
	router.Run(":8080")
}
