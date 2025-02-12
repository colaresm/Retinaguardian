package api

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"
	"retinaguard/responses"
)

// postLogin
// @Summary Get access token
// @Description Get your access token
// @Tags Login Handler
// @Accept json
// @Produce json
// @Success 200 {object} models.AuthResponse
// @Router /api/login [POST]
func loginHandler(queries *db.Queries) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var u models.User
		json.NewDecoder(r.Body).Decode(&u)
		foundUser, err := queries.GetUserByEmail(context.Background(), u.Email)
		if err != nil {
			log.Println(err)
		}
		matchPassword := CheckPasswordHash(u.Password, foundUser.Password)
		if u.Email == foundUser.Email && matchPassword {
			accessToken, err := CreateToken(u.Email)
			if err != nil {
				responses.SendJSON(w, models.Response{Data: models.Response{
					Error: err.Error()}}, http.StatusInternalServerError)
			}
			responses.SendJSON(w, models.Response{
				Data: models.AuthResponse{AccessToken: accessToken}}, http.StatusOK)
			return
		} else {
			responses.SendJSON(w, models.Response{
				Data: models.Response{Error: "Invalid credentials"}}, http.StatusUnauthorized)
		}
	}
}
