package services

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"log"
	"mime/multipart"
	"net/http"
	db "retinaguard/db/db/sqlc"
	"retinaguard/errors"
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
		return
	}
	url := "http://127.0.0.1:5000/api/classify"
	body := &bytes.Buffer{}
	writer := multipart.NewWriter(body)
	part, err := writer.CreateFormFile("retinography", "retinography.jpg")

	if err != nil {
		fmt.Println("Erro ao criar form-data:", err)
		return
	}

	_, err = part.Write(cd.Retinography)
	if err != nil {
		fmt.Println("Erro ao escrever bytes:", err)
		return
	}
	writer.Close()

	req, err := http.NewRequest("POST", url, body)
	if err != nil {
		fmt.Println("Erro ao criar a requisição:", err)
		return
	}

	req.Header.Set("Content-Type", writer.FormDataContentType())

	client := &http.Client{}
	response, err := client.Do(req)
	if err != nil {
		log.Println("Erro ao enviar a requisição:", err)
		return
	}
	defer response.Body.Close()

	var prediction models.PredictionResponse
	err = json.NewDecoder(response.Body).Decode(&prediction)
	if err != nil {
		log.Println(err)
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
	}
	log.Println(prediction.Prediction)
	err = queries.CreateClassification(context.Background(), db.CreateClassificationParams{
		ID:            uuid.New().String(),
		PatientID:     cd.PatientId,
		Retinography:  cd.Retinography,
		PerformedDate: dataTime,
		Prediction:    int32(utils.ConvertPredictionResponseToIota(prediction.Prediction)),
	})

	if err != nil {
		log.Println(err)
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
		return
	}

}
