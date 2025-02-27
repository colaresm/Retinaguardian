package api

import (
	"net/http"
	db "retinaguard/db/db/sqlc"
	"retinaguard/errors"
	"retinaguard/models"
	"retinaguard/responses"
	"retinaguard/services"
	"retinaguard/utils"
)

// CreateClassificationHandler
// @Summary Create Classification
// @Description Create Classification
// @Tags Create Classification Handler
// @Accept json
// @Produce json
// @Success 201 {object} models.CreateClassificationRequest
// @Router /api/classification [POST]
func classificationHandler(queries *db.Queries) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		err := r.ParseMultipartForm(10 << 20)
		if err != nil {
			responses.ClassificationErrorResponse(w, errors.ClassificationCreationError(err))
			return
		}

		retinography := []byte(r.FormValue("retinography"))
		patientId := string(r.FormValue("patient_id"))

		services.CreateNewClassification(utils.CreateClassificationParams{
			Queries:      queries,
			W:            w,
			Retinography: retinography,
			PatientId:    patientId})

		responses.SendJSON(w, models.Response{Data: nil}, http.StatusCreated)
	}
}
