package models

type AuthResponse struct {
	AccessToken string `json:"access_token,omitempty"`
	UserId      string `json:"user_id,omitempty"`
}
