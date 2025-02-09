package api

import (
	"encoding/json"
	"log/slog"
	"net/http"
	"retinaguard/models"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	httpSwagger "github.com/swaggo/http-swagger"
)

func NewHandler(db map[string]string) http.Handler {
	r := chi.NewMux()

	r.Use(middleware.Recoverer)
	r.Use(middleware.RequestID)
	r.Use(middleware.Logger)

	r.Get("/api/healthy", handlerHealthy())
	r.Get("/swagger/*", httpSwagger.WrapHandler)

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
// @Tags handlerHealthy
// @Accept json
// @Produce json
// @Success 200 {object} models.Healthy
// @Router /api/healthy [GET]
func handlerHealthy() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var response models.Healthy
		response.IsHealthy = true
		sendJSON(w, models.Response{Data: response}, http.StatusOK)
	}
}
