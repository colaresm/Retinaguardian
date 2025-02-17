package responses

import (
	"net/http"
	"retinaguard/models"
)

func DoctorErrorResponse(w http.ResponseWriter, err error) {
	SendJSON(w, models.Response{Error: err.Error()}, http.StatusBadGateway)
}
