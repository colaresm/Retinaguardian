package errors

type CustomErrorResponse struct {
	message string
}

func (s CustomErrorResponse) Error() string { return s.message }

func PatientCreationError(err error) error {
	return CustomErrorResponse{"Error on create patient: " + err.Error()}
}
func PatientValidationError(err error) error {
	return CustomErrorResponse{"Error on validate patient: " + err.Error()}
}
