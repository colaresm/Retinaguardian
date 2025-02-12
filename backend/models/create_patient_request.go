package models

type CreatePatientRequest struct {
	Name     string `json:"name"`
	Birthday string `json:"birthday"`
	User     User   `json:"user"`
}
