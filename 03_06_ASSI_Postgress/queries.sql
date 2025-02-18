-- Variables and constants
    -- Variable - constant
    DO $$
    <<outer_block>>
    DECLARE
        film_name CONSTANT varchar(50);
        film_year time := clock_timestamp();
        money_spend numeric(10,2) := 56000.54;
    BEGIN
        film_name = split_part('Frankenstain Rigoberto', ' ',1);
        RAISE NOTICE 'Primer Blocke: La película % fue rodada en % costó %', film_name, film_year, money_spend;

        declare
            movie_category varchar(255) := 'Funny';
        begin
            RAISE NOTICE 'Segundo bloque: Esta categorizada cómo % y se ha revalorizado en: %', movie_category, outer_block.money_spend + 1000;
        end;

        RAISE NOTICE 'Salgo del sub-bloque';
    END outer_block $$;

    -- SELECT INTO
    DO
    $$
    DECLARE
       v_title film.title%TYPE;
       v_release_year film.release_year%TYPE;
    BEGIN
       SELECT title, release_year
       INTO v_title, v_release_year
       FROM film
       WHERE film_id = 56;

       RAISE NOTICE 'Título: %, Año de lanzamiento: %', v_title, v_release_year;
    END;
    $$;

    -- ROW TYPE
    DO
    $$
    DECLARE
       v_film film%ROWTYPE;
    BEGIN
       SELECT *
       INTO v_film
       FROM film
       WHERE film_id > 10
       LIMIT 1;
       RAISE NOTICE 'Título: %, Año de lanzamiento: %', v_film.title, v_film.release_year;
    END;
    $$;

    -- RECORD TYPE
    DO
    $$
    DECLARE
       v_actor RECORD;
    BEGIN
       FOR v_actor IN
          SELECT first_name, last_name
          FROM actor
       LOOP
            RAISE NOTICE 'Actor: % %', v_actor.first_name, v_actor.last_name;
       END LOOP;
    END;
    $$;
-- Fin Variables and constants

-- Reporting messages and errors
    -- Raising errors
    DO $$
    DECLARE
    film_name CONSTANT varchar(50) := split_part('Frankenstain Rigoberto', ' ', 1);
    film_year timestamp := clock_timestamp();
    money_spend CONSTANT numeric(10,2) := 56000.54;
    max_budget CONSTANT numeric(10,2) := 50000.00;
    BEGIN

    IF money_spend > max_budget THEN
        RAISE EXCEPTION 'Error: El gasto de la película % excede el presupuesto máximo de %. Gasto actual: %', film_name, max_budget, money_spend;
    END IF;

    RAISE NOTICE 'Primer bloque: La película % fue rodada en % y costó %', film_name, film_year, money_spend;

    DECLARE
        movie_category varchar(255) := 'Funny';
    BEGIN
        RAISE NOTICE 'Segundo bloque: Esta categorizada como % y se ha revalorizado en: %', movie_category, money_spend + 1000;
    END;

    RAISE NOTICE 'Salgo del sub-bloque';
    END $$;

    -- ASSERT
     DO $$
    DECLARE
        film_name CONSTANT varchar(250) := split_part('Frankenstain Rigoberto', ' ', 1);
        film_year timestamp := clock_timestamp();
        money_spend CONSTANT numeric(10,2) := 56000.54;
        max_budget CONSTANT numeric(10,2) := 50000.00; -- Presupuesto máximo
    BEGIN
        -- Verificación con ASSERT
        IF money_spend > max_budget THEN
			RAISE NOTICE 'Error: El gasto de la película % excede el presupuesto máximo de %. Gasto actual: %', film_name, max_budget, money_spend;
		END IF;

		ASSERT money_spend < max_budget;
        RAISE NOTICE 'Primer bloque: La película % fue rodada en % y costó %', film_name, film_year, money_spend;
    END $$;

-- Fin Reporting messages and errors

-- CONTROL STRUCTURES

    -- IF - THEN
    DO $$
    DECLARE
        rental_count INT;
        v_customer_id INT := 20;
    BEGIN
        SELECT COUNT(*)
        INTO rental_count
        FROM rental
        WHERE rental.customer_id = v_customer_id;
        IF rental_count > 10 THEN
            RAISE NOTICE 'El cliente % ha alquilado más de 10 películas.', v_customer_id;
        ELSE
            RAISE NOTICE 'El cliente % ha alquilado % películas.', v_customer_id, rental_count;
        END IF;
    END $$;

    -- CASE
    DO $$
    DECLARE
    v_customer_id INT := 4;
    rental_count INT;
    type_of_client varchar(250);
    BEGIN
    SELECT COUNT(*) INTO rental_count
    FROM rental
    WHERE rental.customer_id = v_customer_id;
    IF rental_count > 0 THEN
        -- Clasificación del cliente
        CASE
            WHEN rental_count < 5 THEN
                type_of_client := 'Recién llegado';
            WHEN rental_count BETWEEN 5 AND 10 THEN
                type_of_client := 'Cliente habitual';
            ELSE
                type_of_client := 'Cliente que adoro, viene todas las semanas';
        END CASE;
        RAISE NOTICE 'El cliente % es clasificado como %.', v_customer_id, type_of_client;
    ELSE
        RAISE NOTICE 'Customer not found';
    END IF;
    END $$;

    -- FOR LOOP - EXIT
    DO $$
    DECLARE
    movie_title TEXT;
    counter INT := 0;
    BEGIN
    FOR movie_title IN
        SELECT title
        FROM film
        WHERE title LIKE 'E%'
    LOOP
        counter := counter + 1;
        RAISE NOTICE 'Pelicula %: %', counter, movie_title;
        EXIT WHEN counter = 4;
    END LOOP;
    RAISE NOTICE 'Se encontraron % películas que comienzan con E.', counter;  -- Mostrar el resultado
    END $$;

    RAISE NOTICE 'Se encontraron % películas que comienzan con E.', counter;  -- Mostrar el resultado
    END $$;

    -- WHILE
    DO $$
    DECLARE
    v_customer_id INT := 1;
    rental_count INT := 0;
    max_rentals INT := 5;
    BEGIN
    SELECT COUNT(*) INTO rental_count
    FROM rental
    WHERE rental.customer_id = v_customer_id;
    WHILE rental_count < max_rentals LOOP
        RAISE NOTICE 'El cliente % tiene % alquileres. Aún no ha alcanzado el límite.', v_customer_id, rental_count;
        rental_count := rental_count + 1;
    END LOOP;
    RAISE NOTICE 'El cliente % ha alcanzado el límite de % alquileres.', v_customer_id, rental_count;
    END $$;

    RAISE NOTICE 'El cliente % ha alcanzado el límite de % alquileres.', customer_id, rental_count;
    END $$;

-- User-defined functions

    -- CREATE FUNCTION
    CREATE OR REPLACE FUNCTION get_movie_title(film_id INT)
    	RETURNS TEXT
   		LANGUAGE plpgsql
    AS $$
    DECLARE
    	movie_title TEXT;
    BEGIN
    	SELECT title INTO movie_title
   		FROM film
    	WHERE film.film_id = get_movie_title.film_id;

    	RETURN movie_title;
    END;
    $$;

    -- Function Parameter Modes
        -- IN
        CREATE FUNCTION get_movie_count(IN category_name TEXT)
            RETURNS INT
            LANGUAGE plpgsql;
        AS $$
        DECLARE
            movie_count INT;
        BEGIN
            SELECT COUNT(*)
            INTO movie_count
            FROM film_category fc
            JOIN category c ON fc.category_id = c.category_id
            WHERE c.name = category_name;

            RAISE NOTICE 'El numero de las peliculas % categorizadas como: %', movie_count, category_name;

            RETURN movie_count;
        END;
        $$;

        -- OUT
        CREATE OR REPLACE FUNCTION get_rental_info(
            OUT rental_id INT,
            OUT film_id INT,
            OUT customer_id INT
        )
        LANGUAGE plpgsql
        AS $$
        BEGIN
            -- Seleccionar la primera fila de la tabla rental y obtener el film_id desde inventory
            SELECT r.rental_id, i.film_id, r.customer_id
            INTO rental_id, film_id, customer_id
            FROM rental r
            JOIN inventory i ON r.inventory_id = i.inventory_id
            LIMIT 1;

            RETURN;
        END;
        $$;

        -- IN OUT

        CREATE OR REPLACE FUNCTION update_rental_return_date(INOUT rental_id INT, IN new_return_date TIMESTAMP)
        LANGUAGE plpgsql
        AS $$
        BEGIN
            -- Actualizar la fecha de devolución
            UPDATE rental
            SET return_date = new_return_date
            WHERE rental_id = update_rental_return_date.rental_id;

            RETURN;
        END;
        $$;

    -- Function Overloading
    CREATE OR REPLACE FUNCTION get_movie_info(film_id INT)
    RETURNS TEXT
    LANGUAGE plpgsql
    AS $$
    DECLARE
        movie_info TEXT;
    BEGIN
        SELECT title INTO movie_info
        FROM film
        WHERE film.film_id = get_movie_info.film_id;  -- Avoid ambiguity

        RETURN movie_info;
    END;
    $$;

    -- Function Overloading: Fetch movie info by film_title
    CREATE OR REPLACE FUNCTION get_movie_info(film_title TEXT)
    RETURNS TEXT
    LANGUAGE plpgsql
    AS $$
    DECLARE
        movie_info TEXT;
    BEGIN
        SELECT title INTO movie_info
        FROM film
        WHERE film.title = get_movie_info.film_title;

        RETURN movie_info;
    END;
    $$;

    -- Function That Returns a Table
    CREATE OR REPLACE FUNCTION get_all_movies()
    RETURNS TABLE(film_id INT, title VARCHAR(255))  -- Cambiar de TEXT a VARCHAR(255)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT film.film_id, film.title
        FROM film;
    END;
    $$;


    -- Returns SetOf
    CREATE OR REPLACE FUNCTION get_rentals_by_customer(customer_id INT)
    RETURNS SETOF rental
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT *
        FROM rental
        WHERE rental.customer_id = get_rentals_by_customer.customer_id;  -- Usamos "rental.customer_id" para evitar ambigüedad
    END;
    $$;


    -- Drop Function
    DROP FUNCTION get_movie_title(INT);


/* EXAMEN */

/*PROCEDURE*/

/*
Los procedimientos pueden manejar transacciones internamente, lo que significa que se puede utilizar comandos como commit o rollback.
Se utilizan para ejecutar operaciones que no necesariamente devuelven un resultado, como inserciones, actualizaciones, eliminaciones o tareas complejas que involucran múltiples pasos
En este caso, el procedure creado transfer, actualiza la cuenta de un id que da "sender" y otro que recibe "receive" una cantidad específica "amount" de dinero.
En primer lugar subtrae la coantidad de la cuenta sender y posteriormente acualiza con la misma cantidad la cuenta que recive.
 */

create or replace procedure transfer(
   sender int,
   receiver int,
   amount dec
)
language plpgsql
as $$
begin
    -- subtracting the amount from the sender's account
    update accounts
    set balance = balance - amount
    where id = sender;
    -- adding the amount to the receiver's account
    update accounts
    set balance = balance + amount
    where id = receiver;
    commit;
end;
$$;


/*CURSORS*/

/*CURSORS nos permite iterar a través de una consulta secuencialmente fila por fila.
En este caso se declara una funcion  que utiliza un CURSOR para iterar la tabla FILM y devolver un conjunto de registros con los títulos y años de lanzamiento de las películas.

Para ello se utiliza un objeto Cursor film_cursor que almacenara los datos en una variable de tipo RECORD film_record. Por cada fila se retornará
su título p_title y su año de lanzamiento p_release_year. Para iterar cobre el objeto cursor se utiliza un bucle que finaliza si NEXT no enuentra
mas valores para  title y release_year declarados al inicio, es decir cuando no hay más filas.*/

CREATE OR REPLACE FUNCTION fetch_film_titles_and_years(
   OUT p_title VARCHAR(255),
   OUT p_release_year INTEGER
)
RETURNS SETOF RECORD AS
$$
DECLARE
    film_cursor CURSOR FOR
        SELECT title, release_year
        FROM film;
    film_record RECORD;
BEGIN
    -- Open cursor
    OPEN film_cursor;
    -- Fetch rows and return
    LOOP
        FETCH NEXT FROM film_cursor INTO film_record;
        EXIT WHEN NOT FOUND;
        p_title = film_record.title;
        p_release_year = film_record.release_year;
        RETURN NEXT;
    END LOOP;
    -- Close cursor
    CLOSE film_cursor;
END;
$$
LANGUAGE PLPGSQL;


/* TRIGGERS */

/*Triggers
Las funciones que utilizan TRIGGER, se invocan automáticamente cuando un evento acontece en una tabla, tales como: INSERT, UPDATE, DELETE o TRUNCATE.

En este caso la funcion log_last_name_changes() almacena el id, el apellido y el momento (dentro de la tabla employee_audits) cuando
last_name de la tabla employees se actualiza, la palabra reservada NEW representa el nuevo dato y OLD el dato antes de actualizarse.
Para que la función se invoque automáticamente ante un evento  debe ser vinculada a un TRIGGER explicito en este caso last_name_chages, ejecuta
en este caso la funcion last_name_changes.
 */



CREATE OR REPLACE FUNCTION log_last_name_changes()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW.last_name <> OLD.last_name THEN
		 INSERT INTO employee_audits(employee_id,last_name,changed_on)
		 VALUES(OLD.id,OLD.last_name,now());
	END IF;
	RETURN NEW;
END;
$$


CREATE TRIGGER last_name_changes
  BEFORE UPDATE
  ON employees
  FOR EACH ROW
  EXECUTE PROCEDURE log_last_name_changes();



 /*
nested loops
[19:19] Francisco Javier Rosselló Jerónimo
raise notice
[19:19] Francisco Javier Rosselló Jerónimo
outer loop inner loop raise notice print the output
[19:19] Francisco Javier Rosselló Jerónimo
overloading
*/

