viene usato per applicare delle regole alle maschere in bvase all'elaborazione di alcuni dati passati in input

``` sql
INSERT INTO WISE40.WI_MASCHERE_RENDERER (NOME_MASCHERA,NOME_VISTA,NOME_COLONNA,INDICE_REGOLA,REGOLA,BACKGROUND,FOREGROUND,FONT,BACKGROUND_2,FOREGROUND_2,FONT_2,F_BUTTON,DESCRIZIONE) 
VALUES('DB_STATO_GENERALE','DB_CHECK_RMAN_W01','STATO_JOB',1,'#KV;=#STATE_COMPLETED#','0,143,57','0,0,0',NULL,'255,0,0','0,0,0',NULL,'N',NULL);
```

| NOME_MASCHERA       | NOME_VISTA         | NOME_COLONNA | INDICE_REGOLA | REGOLA            | BACKGROUND | FOREGROUND | FONT | BACKGROUND_2 | FOREGROUND_2 | FONT_2 | F_BUTTON | DESCRIZIONE       |
|---------------------|--------------------|--------------|---------------|-------------------|------------|------------|------|--------------|--------------|--------|----------|-------------------|
| DB_STATO_GENERALE   | DB_CHECK_RMAN_W01  | STATO_JOB    | 1             | #KV;=#STATE_COMPLETED# | 0,143,57   | 0,0,0      | NULL | 255,0,0      | 0,0,0        | NULL   | N        |                   |
| maschera riferimento| vista riferimento  | colonna rif  | indice +regole| #KV;=#STATE_COMPLETED# | 0,143,57   | 0,0,0      | NULL | 255,0,0      | 0,0,0        | NULL   | N        |                   |


attenzione al campo regola:
```
#KV;=#STATE_COMPLETED#
```
si intende se il valore del campo è state completed


```
#KV;>#STATE_COMPLETED#:1:1:1
```
controlla se il risultato elaborato tra le 2 operazioni segue la regola a |b