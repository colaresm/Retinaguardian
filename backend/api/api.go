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

	r.Get("/api/healthy", healthyHandler())
	r.Get("/api/swagger/*", httpSwagger.WrapHandler)
	r.Post("/api/login", loginHandler())

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
// @Tags healthyHandler
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

// postLogin
// @Summary Get Access token
// @Description Get your access token
// @Tags loginHandler
// @Accept json
// @Produce json
// @Success 200 {object} models.AuthResponse
// @Router /api/login [POST]
func loginHandler() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var u models.User
		json.NewDecoder(r.Body).Decode(&u)

		if u.Username == "Chek" && u.Password == "123456" {
			accessToken, err := CreateToken(u.Username)
			if err != nil {
				sendJSON(w, models.Response{Data: models.Response{Error: err.Error()}}, http.StatusInternalServerError)
			}
			sendJSON(w, models.Response{Data: models.AuthResponse{AccessToken: accessToken}}, http.StatusOK)
			return
		} else {
			sendJSON(w, models.Response{Data: models.Response{Error: "Invalid credentials"}}, http.StatusUnauthorized)

		}
	}
}
