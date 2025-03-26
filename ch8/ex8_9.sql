CREATE OR REPLACE FUNCTION logging_event_trigger()
RETURNS event_trigger AS $$
DECLARE
	command RECORD;
BEGIN
	FOR command IN SELECT * FROM pg_event_trigger_ddl_commands() LOOP
		IF (command.command_tag = 'CREATE TABLE' AND command.object_type = 'table') THEN
			EXECUTE 
			'CREATE TRIGGER audit_trigger ' ||
			'AFTER INSERT OR UPDATE OR DELETE ' ||
			'ON ' || command.object_identity ||
			' FOR EACH ROW ' ||
			'EXECUTE PROCEDURE audit_trigger()';
		END IF;
	END LOOP;
END
$$ LANGUAGE plpgsql;

CREATE EVENT TRIGGER logging_event_trigger
ON ddl_command_end
EXECUTE FUNCTION logging_event_trigger();