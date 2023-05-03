/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT NOT NULL,
	name VARCHAR(20) NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INT NOT NULL,
	neutered BOOL NOT NULL,
	weight_kg DEC(4,2) NOT NULL
);

ALTER TABLE animals ADD species VARCHAR(30);