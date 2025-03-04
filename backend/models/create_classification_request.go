package models

type CreateClassificationRequest struct {
	PatientId    string `json:"patient_id"`
	Retinography []byte `json:"retinography"`
}
