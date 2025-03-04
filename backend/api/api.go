package api

import (
	"database/sql"
	"net/http"
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"
	"retinaguard/responses"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	httpSwagger "github.com/swaggo/http-swagger"
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
	r.Post("/api/doctor", createDoctorHandler(queries))
	r.Post("/api/classification", classificationHandler(queries))
	r.Get("/api/classifications", listClassificationsHandler(queries))

	return r
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
		responses.SendJSON(w, models.Response{Data: response}, http.StatusOK)
	}
}
