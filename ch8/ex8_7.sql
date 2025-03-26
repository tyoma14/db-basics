CREATE OR REPLACE FUNCTION night_constraint()
RETURNS event_trigger AS $$
BEGIN
	IF localtime BETWEEN '00:00' AND '06:00' AND tg_tag LIKE '%CREATE%' THEN
		RAISE EXCEPTION 'Are you crazy? Go to sleep!';
	END IF;
END
$$ LANGUAGE plpgsql;

CREATE EVENT TRIGGER night_constraint
ON ddl_command_start
EXECUTE FUNCTION night_constraint();