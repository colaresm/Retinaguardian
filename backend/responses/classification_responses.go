package responses

import (
	"net/http"
	"retinaguard/models"
)

func ClassificationErrorResponse(w http.ResponseWriter, err error) {
	SendJSON(w, models.Response{Error: err.Error()}, http.StatusBadGateway)
}
