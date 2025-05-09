-- name: CreateUser :exec
INSERT INTO users (id,email, password)
VALUES ($1, $2, $3);

-- name: GetUserByEmail :one
SELECT id, email, password 
FROM users 
WHERE email = $1;

-- name: CreatePatient :exec
INSERT INTO patients (id, name, birthday, user_id)
VALUES ($1, $2, $3, $4);

-- name: CreateDoctor :exec
INSERT INTO doctors (id, name,crm ,birthday, user_id)
VALUES ($1, $2, $3, $4,$5);

-- name: CreateClassification :exec
INSERT INTO classifications (id, user_id,retinography,performed_date,prediction)
VALUES ($1, $2, $3, $4,$5);

-- name: GetClassificationsByPatientId :many
SELECT retinography, performed_date, prediction, user_id  
FROM classifications  
WHERE user_id = $1;


