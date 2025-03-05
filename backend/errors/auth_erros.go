package errors

func EmptyTokenError() error {
	return CustomErrorResponse{"Erro ao logar: Token vazio"}
}

func InvalidTokenError() error {
	return CustomErrorResponse{"Erro ao logar: Token inválido"}
}
