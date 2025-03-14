package validations

import (
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"
)

func IsValidPatient(queries *db.Queries, patient models.CreatePatientRequest) (error, bool) {
	if errorMessage, isValidBasicInformations := IsValidBasicInformations(patient.Name, patient.Birthday); isValidBasicInformations {
		return errorMessage, false
	}
	if errorMessage, isValidUser := IsValidUser(queries, patient.User); !isValidUser {
		return errorMessage, false
	}

	return nil, true
}
