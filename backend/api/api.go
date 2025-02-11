package api

import (
	"context"
	"database/sql"
	"encoding/json"
	"log"
	"log/slog"
	"net/http"
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/google/uuid"
	httpSwagger "github.com/swaggo/http-swagger"
	"golang.org/x/crypto/bcrypt"
)

func NewHandler(database *sql.DB) http.Handler {
	r := chi.NewMux()
	queries := db.New(database)

	r.Use(middleware.Recoverer)
	r.Use(middleware.RequestID)
	r.Use(middleware.Logger)

	r.Get("/api/healthy", healthyHandler())
	r.Get("/api/swagger/*", httpSwagger.WrapHandler)
	r.Post("/api/login", loginHandler(queries))
	r.Post("/api/patient", createPatientHandler(queries))

	return r
}

func sendJSON(w http.ResponseWriter, resp models.Response, status int) {
	w.Header().Set("Content-Type", "applicatoin/json")
	data, err := json.Marshal(resp)
	if err != nil {
		slog.Error("failed to masrshal json data", "error", err)
		sendJSON(w, models.Response{Error: "somenthing went wrong"}, http.StatusInternalServerError)
		return
	}
	w.WriteHeader(status)
	if _, err := w.Write(data); err != nil {
		slog.Error("failed to write response to client", "error", err)
		return
	}
}

// getHealthy
// @Summary Check healthy
// @Description Check if application if healthy
// @Tags Healthy Handler
// @Accept json
// @Produce json
// @Success 200 {object} models.HealthyResponse
// @Router /api/healthy [GET]
func healthyHandler() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var response models.HealthyResponse
		response.IsHealthy = true
		sendJSON(w, models.Response{Data: response}, http.StatusOK)
	}
}

// createPatientHandler
// @Summary Create patient
// @Description Create patient
// @Tags Create Patient Handler
// @Accept json
// @Produce json
// @Success 201 {object} models.User
// @Router /api/patient [POST]
func createPatientHandler(queries *db.Queries) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var u models.User
		json.NewDecoder(r.Body).Decode(&u)
		hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(u.Password), bcrypt.DefaultCost)

		err := queries.CreateUser(context.Background(), db.CreateUserParams{ID: uuid.New().String(),
			Email: u.Email, Password: string(hashedPassword)})
		if err != nil {
			log.Println("Erro ao criar usuário:", err)
			sendJSON(w, models.Response{Data: models.Response{Error: "Erro ao criar usuário"}}, http.StatusBadGateway)

		}
		sendJSON(w, models.Response{Data: models.Response{}}, http.StatusCreated)

	}
}
