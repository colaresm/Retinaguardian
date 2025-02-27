package errors

func ClassificationCreationError(err error) error {
	return CustomErrorResponse{"Erro ao classificar retinografia: " + err.Error()}
}
