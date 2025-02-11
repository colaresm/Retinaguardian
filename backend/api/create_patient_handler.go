package api

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"

	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

// createPatientHandler
// @Summary Create patient
// @Description Create patient
// @Tags Create Patient Handler
// @Accept json
// @Produce json
// @Success 201 {object} models.CreatePatientRequest
// @Router /api/patient [POST]
func createPatientHandler(queries *db.Queries) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var p models.CreatePatientRequest
		json.NewDecoder(r.Body).Decode(&p)
		hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(p.User.Password), bcrypt.DefaultCost)
		userId := uuid.New().String()

		err := queries.CreatePatient(context.Background(), db.CreatePatientParams{
			ID: uuid.New().String(), Name: p.Name, Birthday: p.Birthday, UserID: userId})
		if err != nil {
			log.Println("Error on create patient:", err)
			sendJSON(w, models.Response{Data: models.Response{Error: "Error on create patient"}}, http.StatusBadGateway)
		}
		err = queries.CreateUser(context.Background(), db.CreateUserParams{
			ID:    userId,
			Email: p.User.Email, Password: string(hashedPassword)})
		if err != nil {
			log.Println("Error on create user:", err)
			sendJSON(w, models.Response{Data: models.Response{Error: "Error on create user"}}, http.StatusBadGateway)
		}
		sendJSON(w, models.Response{Data: models.Response{}}, http.StatusCreated)
	}
}
