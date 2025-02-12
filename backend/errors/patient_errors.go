package errors

type CustomErrorResponse struct {
	message string
}

func (c CustomErrorResponse) CustomError() string { return c.message }

func PatientCreation() CustomErrorResponse { return CustomErrorResponse{"operacao invalida"} }
