/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN TRANSACTION; -- begin transaction
UPDATE animals 
SET species = 'unspecified'; -- make changes

SELECT species FROM animals; -- check changes made
ROLLBACK;

SELECT species FROM animals; -- check changes reverted

BEGIN TRANSACTION; -- begin transaction
UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon'; -- make changes
SELECT species FROM animals; -- check changes made

UPDATE animals
SET species = 'pokemon' WHERE name NOT LIKE '%mon'; -- make changes
SELECT species FROM animals; -- check changes made

COMMIT;
SELECT species FROM animals; -- check changes committed

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* Answers to questions from "query and update animals table": */
-- How many animals are there?
SELECT COUNT(name) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(name) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* Answers to questions from "query multiple tables" using JOIN: */
--What animals belong to Melody Pond?
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(animals.name) FROM species LEFT JOIN animals ON species.id = animals.species_id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, species.name, owners.full_name FROM animals JOIN owners ON owners.id = animals.owner_id JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name LIKE 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, animals.escape_attempts, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT COUNT(animals.name), owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY count DESC; -- Show all rows
SELECT COUNT(animals.name), owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY count DESC LIMIT 1; -- Show only the first row
