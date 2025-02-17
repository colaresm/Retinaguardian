package services

import (
	"context"
	"log"
	db "retinaguard/db/db/sqlc"
	"retinaguard/errors"
	"retinaguard/responses"
	"retinaguard/utils"
	"retinaguard/validations"

	"github.com/google/uuid"
)

func CreateNewDoctor(cd utils.CreateDoctorParams) {
	doctor := cd.Doctor
	queries := cd.Queries

	hashedPassword, _ := utils.EncryptPassword(doctor.User.Password)
	userId := uuid.New().String()
	formatedDate, err := utils.FormatDate(doctor.Birthday)
	if err != nil {
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
		return
	}

	if errorMessage, isValidDoctor := validations.IsValidDoctor(cd.Queries, cd.Doctor); !isValidDoctor {
		responses.DoctorErrorResponse(cd.W, errors.DoctorValidationError(errorMessage))
		return
	}
	err = queries.CreateUser(context.Background(), db.CreateUserParams{
		ID:    userId,
		Email: doctor.User.Email, Password: string(hashedPassword)})
	if err != nil {
		log.Println(err)
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
		return
	}
	err = cd.Queries.CreateDoctor(context.Background(), db.CreateDoctorParams{
		ID: uuid.New().String(), Name: doctor.Name, Crm: doctor.Crm, Birthday: formatedDate, UserID: userId})
	if err != nil {
		log.Println(err)
		responses.DoctorErrorResponse(cd.W, errors.DoctorCreationError(err))
		return
	}

}
