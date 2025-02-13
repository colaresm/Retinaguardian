package validations

import (
	"context"
	"errors"
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"
	"retinaguard/utils"
)

func IsValidPatient(queries *db.Queries, patient models.CreatePatientRequest) (error, bool) {
	if !utils.IsValidEmail(patient.User.Email) {
		return errors.New("invalid email"), false
	}
	if patient.Name == "" {
		return errors.New("name is empty"), false
	}
	if patient.User.Password == "" {
		return errors.New("password is empty"), false
	}

	foundUser, _ := queries.GetUserByEmail(context.Background(), patient.User.Email)
	if utils.IsEmailAlreadyRegistered(foundUser.Email, patient.User.Email) {
		return errors.New("email already registered"), false
	}

	return nil, true
}
