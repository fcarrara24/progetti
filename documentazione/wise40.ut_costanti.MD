puoi usare la tabella ut_costanti per definire costanti di una tabella con regola annessa

``` sql 
INSERT INTO WISE40.UT_COSTANTI (ID_COST,VALORE,ORDINAMENTO,DECODIFICA,MODULO,TABELLA,CAMPO,CR,BACKGROUND,FOREGROUND) 
VALUES('STATE_COMPLETED','COMPLETED',1,'COMPLETED','WISE01','RMAN_STATUS','STATUS',NULL,NULL,NULL);

```
| ID_COST                             | VALORE                                | ORDINAMENTO | DECODIFICA | MODULO | TABELLA     | CAMPO  | CR   | BACKGROUND | FOREGROUND |
|-------------------------------------|---------------------------------------|-------------|------------|--------|-------------|--------|------|------------|------------|
| <span style="color: red;">id</span> |<span style="color: green;">val</span> | ordine           | val  | WISE01 | RMAN_STATUS | STATUS | NULL | NULL       | NULL       |
| STATE_COMPLETED                     | COMPLETED | 1           | COMPLETED  | WISE01 | RMAN_STATUS | STATUS | NULL | NULL       | NULL       |

