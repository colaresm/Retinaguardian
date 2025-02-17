package validations

import (
	"errors"
	"retinaguard/utils"
)

func IsValidBasicInformations(name string, date string) (error, bool) {
	if name == "" {
		return errors.New("nome vazio"), false
	}
	if errorMessage, isValidDate := utils.ValidateDate(date); isValidDate {
		return errorMessage, false
	}
	return nil, true
}
