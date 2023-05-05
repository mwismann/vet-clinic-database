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


-- Create a table called owners with the following columns:
CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(30),
  age INT,
  PRIMARY KEY(id)
);

-- Create a table called species with the following columns:
CREATE TABLE species(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(30),
  PRIMARY KEY(id)
);

-- Modify animals table as follows:
-- Set id as auto incremented primary key.
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

-- Remove the species column.
ALTER TABLE animals DROP COLUMN species;

-- Add a column called species_id which references the id column of the species table.
ALTER TABLE animals ADD species_id INT REFERENCES species(id);

-- Add a column called owner_id which references the id column of the owners table.
ALTER TABLE animals ADD owner_id INT REFERENCES owners(id);
-- Create a table called vets with the following columns:
CREATE TABLE vets(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(30),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

-- Create a join table called specializations with the following columns:
CREATE TABLE specializations(
  id INT GENERATED ALWAYS AS IDENTITY,
  vet_id INT REFERENCES vets(id),
  species_id INT REFERENCES species(id),
  PRIMARY KEY(id)
);

-- Create a join table called visits with the following columns:
CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT REFERENCES animals(id),
  vet_id INT REFERENCES vets(id),
  date_of_visit DATE,
  PRIMARY KEY(id)
);