package responses

import (
	"encoding/json"
	"log"
	"log/slog"
	"net/http"

	"retinaguard/models"
)

func SendJSON(w http.ResponseWriter, resp models.Response, status int) {
	w.Header().Set("Content-Type", "applicatoin/json")
	data, err := json.Marshal(resp)
	if err != nil {
		slog.Error("failed to masrshal json data", "error", err)
		SendJSON(w, models.Response{Error: "somenthing went wrong"}, http.StatusInternalServerError)
		return
	}
	log.Println("data")
	w.WriteHeader(status)
	if _, err := w.Write(data); err != nil {
		slog.Error("failed to write response to client", "error", err)
		return
	}
}

func PatientErrorResponse(w http.ResponseWriter, err error) {
	SendJSON(w, models.Response{Error: err.Error()}, http.StatusBadGateway)
}
