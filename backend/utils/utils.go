package utils

import (
	"errors"
	"net/http"
	"regexp"
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"
	"time"

	"golang.org/x/crypto/bcrypt"
)

func FormatDate(date string) (time.Time, error) {
	layout := "2006-01-02"
	formatedDate, err := time.Parse(layout, date)
	return formatedDate, err
}

func EncryptPassword(password string) ([]byte, error) {
	encryptedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	return encryptedPassword, err
}

type CreatePatientParams struct {
	Queries *db.Queries
	W       http.ResponseWriter
	Patient models.CreatePatientRequest
}

type CreateDoctorParams struct {
	Queries *db.Queries
	W       http.ResponseWriter
	Doctor  models.CreateDoctorRequest
}
type CreateClassificationParams struct {
	Queries      *db.Queries
	W            http.ResponseWriter
	Retinography []byte
	PatientId    string
}

func IsValidEmail(email string) bool {
	emailRegex := `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`
	re := regexp.MustCompile(emailRegex)
	return re.MatchString(email)
}

func IsEmailAlreadyRegistered(oldEmail, newEmail string) bool {
	return oldEmail == newEmail
}

func ValidateDate(date string) (error, bool) {
	if date == "" {
		return errors.New("a data não pode ser vazia"), false
	}

	inputDate, err := time.Parse("2006-01-02", date)
	if err != nil {
		return errors.New("erro ao converter a data"), false
	}

	today := time.Now().Format("2006-01-02")
	currentDate, _ := time.Parse("2006-01-02", today)

	if inputDate.Equal(currentDate) || inputDate.After(currentDate) {
		return errors.New("a data fornecida é igual ou posterior à data atual"), false
	}
	return nil, true
}
