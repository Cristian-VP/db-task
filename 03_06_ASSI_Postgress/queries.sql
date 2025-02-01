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
        film_name CONSTANT varchar(50) := split_part('Frankenstain Rigoberto', ' ', 1);
        film_year timestamp := clock_timestamp();
        money_spend CONSTANT numeric(10,2) := 56000.54;
        max_budget CONSTANT numeric(10,2) := 50000.00; -- Presupuesto máximo
    BEGIN
        -- Verificación con ASSERT
        ASSERT money_spend > max_budget , 'Error: El gasto de la película % excede el presupuesto máximo de %. Gasto actual: %'

        RAISE NOTICE 'Primer bloque: La película % fue rodada en % y costó %', film_name, film_year, money_spend;

        DECLARE
            movie_category varchar(255) := 'Funny';
        BEGIN
            RAISE NOTICE 'Segundo bloque: Esta categorizada como % y se ha revalorizado en: %', movie_category, money_spend + 1000;
        END;

        RAISE NOTICE 'Salgo del sub-bloque';
    END $$;

-- Fin Reporting messages and errors

-- CONTROL STRUCTURES

    -- IF - THEN
    DO $$
    DECLARE
        rental_count INT;
        customer_id INT := 20;
    BEGIN
        SELECT COUNT(*)
        INTO rental_count
        FROM rental
        WHERE customer_id = customer_id;

        IF rental_count > 10 THEN
            RAISE NOTICE 'El cliente % ha alquilado más de 10 películas.', customer_id;
        ELSE
            RAISE NOTICE 'El cliente % ha alquilado % películas.', customer_id, rental_count;
        END IF;
    END $$;

    -- CASE
    DO $$
    DECLARE
    customer_id INT := 4;
    rental_count INT;
    type_of_client varchar(250);
    BEGIN
    SELECT COUNT(*) INTO rental_count
    FROM rental
    WHERE customer_id = customer_id;
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

        RAISE NOTICE 'El cliente % es clasificado como %.', customer_id, type_of_client;
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
    << counter_loop >>
    LOOP
        counter := counter + 1;
        RAISE NOTICE '%', counter;
        EXIT WHEN counter_loop = 4;
    END LOOP;

    RAISE NOTICE 'Se encontraron % películas que comienzan con E.', counter;  -- Mostrar el resultado
    END $$;

    -- WHILE
    DO $$
    DECLARE
    customer_id INT := 1;
    rental_count INT := 0;
    max_rentals INT := 5;
    BEGIN
    SELECT COUNT(*) INTO rental_count
    FROM rental
    WHERE customer_id = customer_id;
    WHILE rental_count < max_rentals LOOP
        RAISE NOTICE 'El cliente % tiene % alquileres. Aún no ha alcanzado el límite.', customer_id, rental_count;
        rental_count := rental_count + 1;
    END LOOP;

    RAISE NOTICE 'El cliente % ha alcanzado el límite de % alquileres.', customer_id, rental_count;
    END $$;

-- User-defined functions

    -- CREATE FUNCTION
    CREATE FUNCTION get_movie_title(film_id INT)
    RETURNS TEXT
    LANGUAGE plpgsql;
    AS $$
    DECLARE
    movie_title TEXT;
    BEGIN
    SELECT title INTO movie_title
    FROM film
    WHERE film_id = film_id;

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

        RETURN movie_count;
        RAISE NOTICE 'El numero de las peliculas % categorizadas como: %', movie_count, category_name;
        END;
        $$

        -- OUT
        CREATE FUNCTION get_rental_info(OUT rental_id INT, OUT film_id INT, OUT customer_id INT)
        LANGUAGE plpgsql
        AS $$
        BEGIN
        SELECT r.rental_id, r.film_id, r.customer_id
        INTO rental_id, film_id, customer_id
        FROM rental r
        LIMIT 1;
        END;
        $$;

        -- IN OUT
        CREATE OR REPLACE FUNCTION update_rental_status(INOUT rental_id INT, IN new_status TEXT)
        LANGUAGE plpgsql;
        AS $$
        BEGIN
        UPDATE rental
        SET status = new_status
        WHERE rental_id = rental_id;
        RAISE NOTICE 'El estado del alquiler % ha sido actualizado a %', rental_id, new_status;
        END;
        $$

    -- Function Overloading
    CREATE FUNCTION get_movie_info(film_id INT)
    RETURNS TEXT
    LANGUAGE plpgsql
    AS $$
    DECLARE
        movie_info TEXT;
    BEGIN
        SELECT title INTO movie_info
        FROM film
        WHERE film_id = film_id;

        RETURN movie_info;
    END;
    $$ LANGUAGE plpgsql;

    CREATE FUNCTION get_movie_info(film_title TEXT)
    RETURNS TEXT AS $$
    DECLARE
        movie_info TEXT;
    BEGIN
        SELECT title INTO movie_info
        FROM film
        WHERE title = film_title;

        RETURN movie_info;
    END;
    $$;

    -- Function That Returns a Table
    CREATE FUNCTION get_all_movies()
    RETURNS TABLE(film_id INT, title TEXT)
    LANGUAGE plpgsql
    AS $$
    BEGIN
    RETURN QUERY
    SELECT film_id, title
    FROM film;
    END;
    $$;

    -- Returns SetOf
    CREATE FUNCTION get_rentals_by_customer(customer_id INT)
    RETURNS SETOF rental
    LANGUAGE plpgsql
    AS $$
    BEGIN
    RETURN QUERY
    SELECT *
    FROM rental
    WHERE customer_id = customer_id;
    END;
    $$;

    -- Drop Function
    DROP FUNCTION get_movie_title(INT);









