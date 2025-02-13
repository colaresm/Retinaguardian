package utils

import (
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

func IsValidEmail(email string) bool {
	emailRegex := `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`
	re := regexp.MustCompile(emailRegex)
	return re.MatchString(email)
}

func IsEmailAlreadyRegistered(oldEmail, newEmail string) bool {
	return oldEmail == newEmail
}
