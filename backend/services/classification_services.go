package services

import (
	"context"
	"encoding/json"
	"log"
	db "retinaguard/db/db/sqlc"
	"retinaguard/errors"
	"retinaguard/infraestructure"
	"retinaguard/models"
	"retinaguard/responses"
	"retinaguard/utils"
	"time"

	"github.com/google/uuid"
)

func CreateNewClassification(cd utils.CreateClassificationParams) {
	queries := cd.Queries
	dataTime, err := time.Parse("2006-01-02", time.Now().Format("2006-01-02"))
	if err != nil {
		log.Println("Erro ao converter a data:", err)
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
		return
	}

	prediction, err := GetPrediction(cd)
	if err != nil {
		log.Println(err)
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
		return
	}

	err = queries.CreateClassification(context.Background(), db.CreateClassificationParams{
		ID:            uuid.New().String(),
		PatientID:     cd.PatientId,
		Retinography:  cd.Retinography,
		PerformedDate: dataTime,
		Prediction:    prediction,
	})

	if err != nil {
		log.Println(err)
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
		return
	}
}
func GetPrediction(cd utils.CreateClassificationParams) (int32, error) {
	classificationUrl, err := utils.BuildUrlFromDotEnv("%s/api/classify")
	if err != nil {
		return 0, err
	}

	response, err := infraestructure.PostWithFormData(
		models.FormDataBody{
			Url:           classificationUrl,
			Data:          cd.Retinography,
			FileName:      "retinography",
			FileExtension: "retinography.png"})
	if err != nil {
		log.Println(err)
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
	}
	var prediction models.PredictionResponse
	err = json.NewDecoder(response).Decode(&prediction)
	if err != nil {
		log.Println(err)
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
	}
	return int32(utils.ConvertPredictionResponseToIota(prediction.Prediction)), nil
}

func GetClassificationsByPatientId(lc utils.ListClassificationParams) ([]db.GetClassificationsByPatientIdRow, error) {
	queries := lc.Queries

	classificationsList, err := queries.GetClassificationsByPatientId(context.Background(), lc.PatientId)
	if err != nil {
		log.Println(err)
		responses.DoctorErrorResponse(lc.W, errors.DoctorCreationError(err))
		return nil, err
	}

	return classificationsList, nil
}
