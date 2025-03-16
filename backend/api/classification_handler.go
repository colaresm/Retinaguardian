package api

import (
	"io"
	"log"
	"net/http"
	db "retinaguard/db/db/sqlc"
	"retinaguard/errors"
	"retinaguard/models"
	"retinaguard/responses"
	"retinaguard/services"
	"retinaguard/utils"
	"retinaguard/validations"
)

// CreateClassificationHandler
// @Summary Create Classification
// @Description Create Classification
// @Tags Classification
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

		file, _, err := r.FormFile("retinography")
		if err != nil {
			http.Error(w, "Erro ao receber o arquivo", http.StatusBadRequest)
			log.Println("Erro ao acessar o arquivo:", err)
			return
		}
		defer file.Close()
		userId := string(r.FormValue("patient_id"))

		retinography, _ := io.ReadAll(file)
		services.CreateNewClassification(utils.CreateClassificationParams{
			Queries:      queries,
			W:            w,
			Retinography: retinography,
			UserId:       userId})

		responses.SendJSON(w, models.Response{Data: nil}, http.StatusCreated)
	}
}

// getClassifications
// @Summary Get Classifications
// @Description Get List Of Classifications By Patient
// @Tags Classification
// @Accept json
// @Produce json
// @Success 200 {object} models.ClassificationResponse
// @Router /api/classifications [GET]
func listClassificationsHandler(queries *db.Queries) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")

		err := validations.ValidateToken(w, r)
		if err != nil {
			log.Println(err)
			return
		}

		userId := r.URL.Query().Get("user_id")

		classifications, err := services.GetClassificationsByPatientId(
			utils.ListClassificationParams{
				Queries: queries,
				UserId:  userId,
				W:       w,
			})
		if err != nil {
			responses.ClassificationErrorResponse(w, errors.ClassificationListError(err))
			return
		}

		classificationsMapped, err := utils.MapClassifications(classifications)
		if err != nil {
			responses.ClassificationErrorResponse(w, errors.ClassificationListError(err))
			return
		}
		responses.SendJSON(w, models.Response{Data: classificationsMapped}, http.StatusOK)
	}
}
