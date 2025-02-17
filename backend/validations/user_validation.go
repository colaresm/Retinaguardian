package validations

import (
	"context"
	"errors"
	db "retinaguard/db/db/sqlc"
	"retinaguard/models"
	"retinaguard/utils"
)

func IsValidUser(queries *db.Queries, user models.User) (error, bool) {
	if !utils.IsValidEmail(user.Email) {
		return errors.New("email inválido"), false
	}

	if user.Password == "" {
		return errors.New("senha vazia"), false
	}

	foundUser, _ := queries.GetUserByEmail(context.Background(), user.Email)
	if utils.IsEmailAlreadyRegistered(foundUser.Email, user.Email) {
		return errors.New("email já registrado"), false
	}

	return nil, true
}
