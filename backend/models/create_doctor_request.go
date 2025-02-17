package models

type CreateDoctorRequest struct {
	Name     string `json:"name"`
	Crm      string `json:"crm"`
	Birthday string `json:"birthday"`
	User     User   `json:"user"`
}
