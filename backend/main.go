package main

import (
	"database/sql"
	"log"
	"log/slog"
	"net/http"
	"os"
	"retinaguard/api"
	_ "retinaguard/docs"
	"time"

	_ "github.com/golang-migrate/migrate/v4/database/postgres" // Importa o driver do Postgres
	_ "github.com/golang-migrate/migrate/v4/source/file"       // Importa o driver de arquivos

	_ "github.com/jackc/pgx/v5/stdlib"
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
	database, err := startDatabase()
	if err != nil {
		return err
	}

	handler := api.NewHandler(database)

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

func startDatabase() (*sql.DB, error) {
	connStr := "postgresql://postgres:admim@localhost:5432/postgres?sslmode=disable"
	db, err := sql.Open("pgx", connStr)
	if err != nil {
		log.Println("Erro ao conectar ao banco:", err)
		return nil, err
	}

	if err := db.Ping(); err != nil {
		log.Println("Erro ao testar conexão com o banco:", err)
		db.Close()
		return nil, err
	}

	return db, nil
}
