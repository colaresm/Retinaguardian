package responses

import (
	"net/http"
	"retinaguard/models"
)

func AuthErrorResponse(w http.ResponseWriter, err error) {
	SendJSON(w, models.Response{Error: err.Error()}, http.StatusBadGateway)
}
