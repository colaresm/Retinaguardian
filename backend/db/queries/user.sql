-- name: CreateUser :exec
INSERT INTO users (id,email, password)
VALUES ($1, $2, $3);

-- name: GetUserByEmail :one
SELECT id, email, password 
FROM users 
WHERE email = $1;
