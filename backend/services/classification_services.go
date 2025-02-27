package services

import (
	"context"
	"log"
	db "retinaguard/db/db/sqlc"
	"retinaguard/errors"
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
	err = queries.CreateClassification(context.Background(), db.CreateClassificationParams{
		ID:            uuid.New().String(),
		PatientID:     cd.PatientId,
		Retinography:  cd.Retinography,
		PerformedDate: dataTime,
	})
	if err != nil {
		log.Println(err)
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
		return
	}

}
