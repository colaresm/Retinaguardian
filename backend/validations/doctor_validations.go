package validations

import (
	"errors"
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"
)

func IsValidDoctor(queries *db.Queries, doctor models.CreateDoctorRequest) (error, bool) {
	if errorMessage, isValidBasicInformations := IsValidBasicInformations(doctor.Name, doctor.Birthday); isValidBasicInformations {
		return errorMessage, false
	}
	if doctor.Crm == "" {
		return errors.New("CRM inválido"), false
	}
	if errorMessage, isValidUser := IsValidUser(queries, doctor.User); isValidUser {
		return errorMessage, false
	}
	return nil, true
}
