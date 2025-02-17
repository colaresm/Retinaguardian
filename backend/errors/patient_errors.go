package errors

type CustomErrorResponse struct {
	message string
}

func (s CustomErrorResponse) Error() string { return s.message }

func PatientCreationError(err error) error {
	return CustomErrorResponse{"Erro ao criar paciente: " + err.Error()}
}
func PatientValidationError(err error) error {
	return CustomErrorResponse{"Erro ao validar o paciente: " + err.Error()}
}
