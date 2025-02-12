package api

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"
	"retinaguard/responses"
	"retinaguard/utils"

	"github.com/google/uuid"
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
		hashedPassword, _ := utils.EncryptPassword(p.User.Password)
		userId := uuid.New().String()

		formatedDate, err := utils.FormatDate(p.Birthday)
		if err != nil {
			responses.PatientCreationError(w)
		}

		err = queries.CreatePatient(context.Background(), db.CreatePatientParams{
			ID: uuid.New().String(), Name: p.Name, Birthday: formatedDate, UserID: userId})
		if err != nil {
			responses.PatientCreationError(w)
		}

		err = queries.CreateUser(context.Background(), db.CreateUserParams{
			ID:    userId,
			Email: p.User.Email, Password: string(hashedPassword)})

		if err != nil {
			log.Println("Error on create user:", err)
			responses.PatientCreationError(w)
		}
		responses.SendJSON(w, models.Response{Data: models.Response{}}, http.StatusCreated)
	}
}
