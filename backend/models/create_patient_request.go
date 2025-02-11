package models

import "time"

type CreatePatientRequest struct {
	Name     string    `json:"name"`
	Birthday time.Time `json:"birthday"`
	User     User      `json:"user"`
}
