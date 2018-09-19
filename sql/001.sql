SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = ON;
SET check_function_bodies = FALSE;
SET client_min_messages = WARNING;

CREATE SCHEMA store
  AUTHORIZATION dummy;


CREATE TABLE store.films (
	uid 		SERIAL PRIMARY KEY,
    title       varchar(125),
    kind        varchar(125),
    last_update timestamp default now()
);

COMMENT ON COLUMN store.films.title IS 'The title of the movie';
COMMENT ON COLUMN store.films.kind IS 'The kind of movie';
COMMENT ON COLUMN store.films.last_update IS 'Time stamp - it updates to now() for every insert or update';



--
-- Update last_update column to now()
--
CREATE OR REPLACE FUNCTION update_modified_column() 
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_update = now();
    RETURN NEW; 
END;
$$ language 'plpgsql';

-- Trigger the function for inserts and updates

CREATE TRIGGER update_customer_modtime BEFORE UPDATE ON store.films FOR EACH ROW EXECUTE PROCEDURE  update_modified_column();

insert into store.films(title,kind) values ('Indiana Jones','Adventure');
insert into store.films(title,kind) values ('Blade Runner','Science Fiction');
insert into store.films(title,kind) values ('Avengers', 'Superhero');
insert into store.films(title,kind) values (,'The man from earth', 'Science Fiction');