package models

type ClassificationResponse struct {
	Retinography  []byte `json:"retinography"`
	PerformedDate string `json:"performed_date"`
	Prediction    string `json:"prediction"`
}
