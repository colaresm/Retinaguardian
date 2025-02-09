package main

import (
	"log/slog"
	"net/http"
	"os"
	"retinaguard/api"
	_ "retinaguard/docs"
	"time"
)

// @title Retinaguard
// @version 1.0
// @description Endpoints of Retinaguard API
// @termsOfService http://swagger.io/terms/
// @license.name Apache 2.0
// @license.url http://www.apache.org/licenses/LICENSE-2.0.html
// @host localhost:8034
// @BasePath /
func main() {
	if err := run(); err != nil {
		slog.Error("falied to execute code", "error", err)
		os.Exit(1)
	}
	slog.Info("the application is online")
}

func run() error {
	db := make(map[string]string)
	handler := api.NewHandler(db)

	s := http.Server{
		ReadTimeout:  10 * time.Second,
		IdleTimeout:  time.Minute,
		WriteTimeout: 10 * time.Second,
		Addr:         ":8034",
		Handler:      handler,
	}

	if err := s.ListenAndServe(); err != nil {
		return err
	}

	return nil
}
