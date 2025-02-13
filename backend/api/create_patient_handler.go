package api

import (
	"encoding/json"
	_ "errors"
	"net/http"
	db "retinaguard/db/db/sqlc"
	"retinaguard/errors"
	"retinaguard/models"
	"retinaguard/responses"
	"retinaguard/services"
	"retinaguard/utils"
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
		err := json.NewDecoder(r.Body).Decode(&p)
		if err != nil {
			responses.PatientErrorResponse(w, errors.PatientCreationError(err))
			return
		}
		services.CreateNewPatient(utils.CreatePatientParams{Queries: queries, W: w, Patient: p})
		responses.SendJSON(w, models.Response{Data: nil}, http.StatusCreated)
	}
}
