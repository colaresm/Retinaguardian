package errors

func DoctorCreationError(err error) error {
	return CustomErrorResponse{"Erro ao criar médico: " + err.Error()}
}
func DoctorValidationError(err error) error {
	return CustomErrorResponse{"Erro ao validar o médico: " + err.Error()}
}
