CREATE TABLE users (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    password TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

CREATE TABLE patients (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthday DATE NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE doctors (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    crm VARCHAR(255) NOT NULL,
    birthday DATE NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE classifications (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    retinography  BLOB NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    performed_date DATE NOT NULL,
    prediction INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
);
