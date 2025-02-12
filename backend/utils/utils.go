package utils

import (
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
