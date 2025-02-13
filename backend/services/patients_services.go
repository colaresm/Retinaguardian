package services

import (
	"context"
	db "retinaguard/db/db/sqlc"
	"retinaguard/errors"
	"retinaguard/responses"
	"retinaguard/utils"
	"retinaguard/validations"

	"github.com/google/uuid"
)

func CreateNewPatient(cp utils.CreatePatientParams) {
	patient := cp.Patient
	queries := cp.Queries

	hashedPassword, _ := utils.EncryptPassword(patient.User.Password)
	userId := uuid.New().String()
	formatedDate, err := utils.FormatDate(patient.Birthday)
	if err != nil {
		responses.PatientErrorResponse(cp.W, errors.PatientCreationError(err))
		return
	}

	if errorMessage, isValidPatient := validations.IsValidPatient(cp.Queries, cp.Patient); !isValidPatient {
		responses.PatientErrorResponse(cp.W, errors.PatientValidationError(errorMessage))
		return
	}

	err = cp.Queries.CreatePatient(context.Background(), db.CreatePatientParams{
		ID: uuid.New().String(), Name: patient.Name, Birthday: formatedDate, UserID: userId})
	if err != nil {
		responses.PatientErrorResponse(cp.W, errors.PatientCreationError(err))
		return
	}

	err = queries.CreateUser(context.Background(), db.CreateUserParams{
		ID:    userId,
		Email: patient.User.Email, Password: string(hashedPassword)})
	if err != nil {
		responses.PatientErrorResponse(cp.W, errors.PatientCreationError(err))
		return
	}
}
