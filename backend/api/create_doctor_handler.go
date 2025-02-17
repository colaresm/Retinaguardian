package api

import (
	"encoding/json"
	"net/http"
	db "retinaguard/db/db/sqlc"
	"retinaguard/errors"
	"retinaguard/models"
	"retinaguard/responses"
	"retinaguard/services"
	"retinaguard/utils"
)

// createDoctorHandler
// @Summary Create Doctor
// @Description Create doctor
// @Tags Create Doctor Handler
// @Accept json
// @Produce json
// @Success 201 {object} models.CreateDoctorRequest
// @Router /api/doctor [POST]
func createDoctorHandler(queries *db.Queries) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var d models.CreateDoctorRequest
		err := json.NewDecoder(r.Body).Decode(&d)
		if err != nil {
			responses.DoctorErrorResponse(w, errors.DoctorCreationError(err))
			return
		}
		services.CreateNewDoctor(utils.CreateDoctorParams{Queries: queries, W: w, Doctor: d})
		responses.SendJSON(w, models.Response{Data: nil}, http.StatusCreated)
	}
}
