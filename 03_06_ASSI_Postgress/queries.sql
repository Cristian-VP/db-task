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

-- EXCEPTION HANDLING
DO $$
DECLARE
    v_film_title TEXT;
BEGIN
    BEGIN
        SELECT title INTO v_film_title
        FROM film
        WHERE film_id = 99999; -- ID inexistente
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE NOTICE 'Error: No se encontró la película con el ID especificado.';
        WHEN OTHERS THEN
            RAISE NOTICE 'Error desconocido: %', SQLERRM;
    END;
    RAISE NOTICE 'Finalizando bloque de manejo de excepciones.';
END $$;

-- Catching Any Generic Error
DO $$
BEGIN
    BEGIN
        PERFORM 1 / 0;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error capturado: %', SQLERRM;
    END;
END $$;

-- Catching a Specific Error
DO $$
BEGIN
    BEGIN
        INSERT INTO film (title) VALUES (NULL);
    EXCEPTION
        WHEN null_value_not_allowed THEN
            RAISE NOTICE 'Error: No se pueden insertar valores nulos en el título de la película.';
    END;
END $$;

-- Handling Exceptions in Nested Blocks
DO $$
BEGIN
    BEGIN
        BEGIN
            SELECT 1/0;
        EXCEPTION
            WHEN division_by_zero THEN
                RAISE NOTICE 'Error interno: División por cero.';
        END;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error externo: %', SQLERRM;
    END;
END $$;

-- Using EXCEPTION to Roll Back Transactions
DO $$
BEGIN
    BEGIN
        INSERT INTO film (title) VALUES ('Nueva Película');
        RAISE EXCEPTION 'Simulando un error, revirtiendo transacción.';
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Transacción revertida debido a error: %', SQLERRM;
    END;
END $$;

-- STORED PROCEDURES
CREATE OR REPLACE PROCEDURE simple_procedure()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Ejecutando un procedimiento almacenado simple.';
END;
$$;

-- Stored Procedure with Input Parameters
CREATE OR REPLACE PROCEDURE insert_movie(p_title TEXT, p_year INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO film (title, release_year) VALUES (p_title, p_year);
    RAISE NOTICE 'Película % insertada.', p_title;
END;
$$;

-- Stored Procedure with Input and Output Parameters
CREATE OR REPLACE PROCEDURE get_movie_count(IN category_name TEXT, OUT movie_count INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) INTO movie_count FROM film_category fc
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = category_name;
END;
$$;

-- Stored Procedure with Transactions
CREATE OR REPLACE PROCEDURE transactional_procedure()
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        INSERT INTO film (title) VALUES ('Nueva Película Transaccional');
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Transacción revertida.';
    END;
END;
$$;

-- CURSORS
DO $$
DECLARE
    cur CURSOR FOR SELECT title FROM film WHERE release_year > 2000;
    v_title TEXT;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO v_title;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Película: %', v_title;
    END LOOP;
    CLOSE cur;
END $$;

-- Cursor with Parameters
DO $$
DECLARE
    cur CURSOR (year_param INT) FOR SELECT title FROM film WHERE release_year > year_param;
    v_title TEXT;
BEGIN
    OPEN cur(2010);
    FETCH cur INTO v_title;
    CLOSE cur;
    RAISE NOTICE 'Película después del 2010: %', v_title;
END $$;

-- Cursor with FETCH FORWARD and MOVE
DO $$
DECLARE
    cur CURSOR FOR SELECT title FROM film;
    v_title TEXT;
BEGIN
    OPEN cur;
    MOVE FORWARD 5 IN cur;
    FETCH cur INTO v_title;
    CLOSE cur;
    RAISE NOTICE 'Sexta película en la lista: %', v_title;
END $$;

-- TRIGGERS
CREATE OR REPLACE FUNCTION before_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    NEW.created_at := now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_film
BEFORE INSERT ON film
FOR EACH ROW
EXECUTE FUNCTION before_insert_trigger();

-- AFTER INSERT Trigger for Logging
CREATE OR REPLACE FUNCTION after_insert_log()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO film_log (film_id, action) VALUES (NEW.film_id, 'INSERT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_insert_film
AFTER INSERT ON film
FOR EACH ROW
EXECUTE FUNCTION after_insert_log();

-- BEFORE UPDATE Trigger to Prevent Changes
CREATE OR REPLACE FUNCTION before_update_restrict()
RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION 'No se permite actualizar la tabla film directamente.';
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_update_film
BEFORE UPDATE ON film
FOR EACH ROW
EXECUTE FUNCTION before_update_restrict();

-- AFTER DELETE Trigger for Logging Deletions
CREATE OR REPLACE FUNCTION after_delete_log()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO film_log (film_id, action) VALUES (OLD.film_id, 'DELETE');
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_delete_film
AFTER DELETE ON film
FOR EACH ROW
EXECUTE FUNCTION after_delete_log();
