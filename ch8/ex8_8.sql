CREATE TABLE logs (
	id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	log_time timestamp NOT NULL,
	usr varchar(30) NOT NULL,
	operation text NOT NULL,
	message json
);

CREATE OR REPLACE FUNCTION audit_trigger()
RETURNS trigger AS $$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		INSERT INTO logs(log_time, usr, operation, message)
		SELECT now(), current_user, TG_OP, row_to_json(NEW);
	ELSIF (TG_OP = 'UPDATE') THEN
		INSERT INTO logs(log_time, usr, operation, message)
		SELECT now(), current_user, TG_OP, row_to_json(NEW);
	ELSIF (TG_OP = 'DELETE') THEN
		INSERT INTO logs(log_time, usr, operation, message)
		SELECT now(), current_user, TG_OP, row_to_json(OLD);
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER audit_trigger 
AFTER INSERT OR UPDATE OR DELETE
ON flights
FOR EACH ROW
EXECUTE PROCEDURE audit_trigger();