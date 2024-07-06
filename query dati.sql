CREATE OR REPLACE FUNCTION get_unique_chars(p_id_udc NUMBER, p_cod_articolo VARCHAR2)
RETURN VARCHAR2 IS
    v_result VARCHAR2(100);  -- Aumentato da 50 a 100 per supportare stringhe più lunghe
    v_len NUMBER := LENGTH(p_cod_articolo);
    v_char_count NUMBER;
    --v_unique_count NUMBER;
	
	v_sensib_iniz   NUMBER := 1; --sensibilita per distanza max da inizio
	v_sensib_fine   NUMBER := 1; --sensibilita per distanza massima fine
BEGIN
    v_result := '';
    
    FOR i IN 1..v_len LOOP
        
        --se facilmente identificabile da occhio umano (l'indice è minore 
        --di sensibilita inizio e maggiore lung-sens.fine)
        IF (i<v_sensib_iniz ) OR (i> v_len-v_sensib_fine ) THEN
            IF i <= v_len / 2 THEN
                -- Prima metà della stringa
    
                SELECT COUNT(SUBSTR(cod_articolo, i, 1))
                INTO v_char_count
                FROM udc_articoli
                WHERE id_udc = p_id_udc
                AND SUBSTR(cod_articolo, i, 1) = SUBSTR(p_cod_articolo, i, 1)
        		AND cod_articolo <> p_cod_articolo;
    
                IF v_char_count = 0 THEN
                    v_result := v_result || SUBSTR(p_cod_articolo, i, 1);
                ELSE
                    v_result := v_result || '_';
                END IF;
            ELSE
                -- Seconda metà della stringa
                DECLARE
                    v_pos_from_end NUMBER := v_len - i + 1;
                    v_rev_pos NUMBER;
                BEGIN
                    v_rev_pos := v_len - v_pos_from_end + 1;

                    SELECT COUNT(SUBSTR(cod_articolo, -v_pos_from_end, 1))
                    INTO v_char_count
                    FROM udc_articoli
                    WHERE id_udc = p_id_udc
                    --AND LENGTH(cod_articolo) >= v_rev_pos  -- Considera solo gli articoli con lunghezza sufficiente
                    AND SUBSTR(cod_articolo, -v_pos_from_end, 1) = SUBSTR(p_cod_articolo, -v_pos_from_end, 1)
                    AND cod_articolo <> p_cod_articolo;
   
                    IF v_char_count = 0 THEN
                        v_result := v_result || SUBSTR(p_cod_articolo, i, 1);
                    ELSE
                        v_result := v_result || '_';
                    END IF;
                END;
            END IF;
		ELSE -- SE NON identificabile facilmente (in posizione illeggibile)
             v_result := v_result || '_';
		END IF;
    END LOOP;

    RETURN v_result;
END get_unique_chars;
