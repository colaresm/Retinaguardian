package errors

func ClassificationCreationError(err error) error {
	return CustomErrorResponse{"Erro ao classificar retinografia: " + err.Error()}
}

func ClassificationListError(err error) error {
	return CustomErrorResponse{"Erro ao listar classificações: " + err.Error()}
}
