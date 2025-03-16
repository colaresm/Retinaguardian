package services

import (
	"context"
	db "retinaguard/db/db/sqlc"
	"retinaguard/utils"
	"retinaguard/validations"

	"github.com/google/uuid"
)

func CreateNewDoctor(cd utils.CreateDoctorParams) error {
	doctor := cd.Doctor
	queries := cd.Queries

	hashedPassword, _ := utils.EncryptPassword(doctor.User.Password)
	userId := uuid.New().String()
	formatedDate, err := utils.FormatDate(doctor.Birthday)
	if err != nil {
		return err
	}

	if errorMessage, isValidDoctor := validations.IsValidDoctor(cd.Queries, cd.Doctor); !isValidDoctor {
		return errorMessage
	}
	err = queries.CreateUser(context.Background(), db.CreateUserParams{
		ID:    userId,
		Email: doctor.User.Email, Password: string(hashedPassword)})
	if err != nil {
		return err
	}
	err = cd.Queries.CreateDoctor(context.Background(), db.CreateDoctorParams{
		ID: uuid.New().String(), Name: doctor.Name, Crm: doctor.Crm, Birthday: formatedDate, UserID: userId})
	if err != nil {
		return err
	}
	return nil
}
