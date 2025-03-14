package utils

import (
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
	"regexp"
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"
	"time"

	"github.com/joho/godotenv"
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
	UserId       string
	Prediction   int
}
type ListClassificationParams struct {
	Queries *db.Queries
	W       http.ResponseWriter
	UserId  string
}

type Prediction int32

const (
	Healthy Prediction = iota
	Presence
)

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

func ConvertPredictionResponseToIota(prediction string) Prediction {
	if prediction == "healthy" {
		return Healthy
	}
	return Presence
}

func BuildUrlFromDotEnv(path string) (string, error) {
	err := godotenv.Load()
	if err != nil {
		log.Println("Erro ao carregar o arquivo .env")
		return "", err
	}

	baseURL := os.Getenv("API_HOST")
	if baseURL == "" {
		log.Println("API_HOST não definida no .env")
		return "", err
	}
	url := fmt.Sprintf(path, baseURL)
	return url, nil
}
func ConvertPredictionToString(prediction int32) string {
	if prediction == 0 {
		return "healthy"
	}
	return "presence"
}
func FormatDateToBrazilianFormat(dateToFormat string) (string, error) {
	layout := "2006-01-02 15:04:05 -0700 MST"

	t, err := time.Parse(layout, dateToFormat)
	if err != nil {
		return "", err
	}

	formattedDate := t.Format("02/01/2006")
	return formattedDate, nil
}

func MapClassifications(classifications []db.GetClassificationsByPatientIdRow) ([]models.ClassificationResponse, error) {
	var responses []models.ClassificationResponse

	for _, classification := range classifications {
		performedDate, err := FormatDateToBrazilianFormat(classification.PerformedDate.String())
		if err != nil {
			return nil, err
		}
		response := models.ClassificationResponse{
			Retinography:  classification.Retinography,
			PerformedDate: performedDate,
			Prediction:    ConvertPredictionToString(classification.Prediction),
		}
		responses = append(responses, response)
	}
	return responses, nil
}
