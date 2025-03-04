package infraestructure

import (
	"bytes"
	"io"
	"mime/multipart"
	"net/http"
	"retinaguard/models"
)

func PostWithFormData(params models.FormDataBody) (io.ReadCloser, error) {
	body := &bytes.Buffer{}
	writer := multipart.NewWriter(body)

	part, err := writer.CreateFormFile(params.FileName, params.FileExtension)
	if err != nil {
		return nil, err
	}

	_, err = part.Write(params.Data)
	if err != nil {
		return nil, err
	}

	err = writer.Close()
	if err != nil {
		return nil, err
	}

	req, err := http.NewRequest("POST", params.Url, body)
	if err != nil {
		return nil, err
	}

	req.Header.Set("Content-Type", writer.FormDataContentType())

	client := &http.Client{}
	response, err := client.Do(req)
	if err != nil {
		return nil, err
	}

	return response.Body, nil
}
