package models

type CreatePatientRequest struct {
	Name     string `json:"name"`
	Email    string `json:"email"`
	Username string `json:"username"`
	Password string `json:"password"`
	Birthday string `json:"birthday"`
}
