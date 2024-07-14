CREATE OR REPLACE VIEW wise01.db_check_rman_w01 (
   sessione,
   inizio_job,
   fine_job,
   stato_job,
   tipo_backup,
   data_input_job,
   data_output_job,
   durata_job,
   id_oper,
   operazione,
   inizio_oper,
   fine_oper,
   stato_oper,
   data_input_oper,
   data_output_oper,
   tipo_oggetto )
BEQUEATH DEFINER
AS
SELECT  
    SELECT 
    'SESSION_1' AS sessione,
    SYSDATE -7 AS inizio_job, 
    SYSDATE - 7 + INTERVAL '2' HOUR AS fine_job, 
    'COMPLETED' AS stato_job,  -- da cambiare
    'FULL' AS tipo_backup,
    '100 GB' AS data_input_job,
    '90 GB' AS data_output_job,
    '2 hours' AS durata_job,
    1 AS id_oper, 
    'BACKUP' AS operazione,
    SYSDATE - 7 AS inizio_oper,
    SYSDATE - 7 + INTERVAL '2' HOUR AS fine_oper,
    'COMPLETED' AS stato_oper, --da cambiare
    '100.00G' AS data_input_oper,
    '90.00G' AS data_output_oper,
    'DATAFILE' AS tipo_oggetto
FROM DUAL