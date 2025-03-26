CREATE OR REPLACE FUNCTION flight_distance_constraint() RETURNS trigger 
AS $$
DECLARE
	start_point point;
	end_point point;
	max_distance float;
BEGIN
	SELECT coordinates
	INTO STRICT start_point
	FROM airports
	WHERE airport_code = NEW.departure_airport;
	
	SELECT coordinates
	INTO STRICT end_point
	FROM airports
	WHERE airport_code = NEW.arrival_airport;
	
	SELECT range
	INTO STRICT max_distance
	FROM aircrafts
	WHERE aircraft_code = NEW.aircraft_code;
	
	IF start_point <@> end_point > max_distance THEN
		RAISE EXCEPTION 'distance too much';
	END IF;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER flight_distance_constraint 
BEFORE INSERT OR UPDATE
ON flights
FOR EACH ROW
EXECUTE PROCEDURE flight_distance_constraint();