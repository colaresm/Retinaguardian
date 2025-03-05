package validations

import (
	"net/http"

	"retinaguard/errors"
	"retinaguard/responses"

	"github.com/golang-jwt/jwt/v5"
)

func ValidateToken(w http.ResponseWriter, r *http.Request) error {
	tokenString := r.Header.Get("Authorization")
	if tokenString == "" {
		w.WriteHeader(http.StatusUnauthorized)
		responses.AuthErrorResponse(w, errors.EmptyTokenError())
		return errors.EmptyTokenError()
	}

	tokenString = tokenString[len("Bearer "):]

	err := verifyToken(w, tokenString)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		responses.AuthErrorResponse(w, errors.InvalidTokenError())
		return err
	}
	return nil
}

var secretKey = []byte("secret-key")

func verifyToken(w http.ResponseWriter, tokenString string) error {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		return secretKey, nil
	})

	if err != nil {
		return err
	}

	if !token.Valid {
		responses.AuthErrorResponse(w, errors.InvalidTokenError())
	}

	return nil
}
