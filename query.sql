PACKAGE BODY fca_pck2 IS

    ----------------------------------------------------------------------------

      --FCA 08/07/2024

    ----------------------------------------------------------------------------

 

    ----------------------------------------------------------------------------

      --FCA 08/07/2024 formattazione html del testo

    ----------------------------------------------------------------------------

    FUNCTION FROMATTA_HTML (

        in_id_udc        IN wise01.mc_udp.cod_articolo%TYPE,

        in_cod_articolo  IN wise01.mc_udp.id_udc%TYPE

    )

    RETURN VARCHAR2 IS

        lc_result ut_allarmi.msg_allarme%TYPE;  -- Aumentato da 50 a 100 per supportare stringhe più lunghe

            lc_parsed VARCHAR2(100) := FCA_PCK2.EVIDENZIA_ARTICOLO(in_id_udc, in_cod_articolo);

        ln_len NUMBER := LENGTH(in_cod_articolo);

        lc_msg           ut_allarmi.msg_allarme%TYPE;

 

    BEGIN

        lc_result := '<html><span >';

 

        FOR i IN 1..ln_len LOOP

            IF SUBSTR(lc_parsed, i, 1) = '_' THEN

                  lc_result   := lc_result || SUBSTR ( in_cod_articolo, i, 1 );

            ELSE

                  lc_result   := lc_result || '<b style="background-color: #a5f77c; font-size:1.2em; vertical-align: middle;">' || SUBSTR ( in_cod_articolo, i, 1 ) || '</b>';

            END IF;

        END LOOP;

 

        RETURN lc_result;

    EXCEPTION

        WHEN OTHERS THEN

            RETURN '<html>'||in_id_udc;

    END FROMATTA_HTML;

 

 

 

 

 

 

    ----------------------------------------------------------------------------

      --FCA 08/07/2024 funzione di aiuto per cercare elementi centrali

    ----------------------------------------------------------------------------

 

 

    FUNCTION EVIDENZIA_CENTRALI (

        in_id_udc        IN wise01.mc_udp.cod_articolo%TYPE,

        in_cod_articolo  IN wise01.mc_udp.id_udc%TYPE

    )

    RETURN VARCHAR2 IS

        next1           VARCHAR2(1);

        next2           VARCHAR2(1);

        lc_result       VARCHAR2(100);

        ln_char_count   NUMBER;

        --ln_found            NUMBER;

    BEGIN

      --LN_FOUND := 1; -- 1 FALSE, 2 TRUE

        lc_result := '';

        next1 := '';

        next2 := '';

 

        FOR i IN 1..(LENGTH(in_cod_articolo)) LOOP

            IF LENGTH(next1) > 0 THEN

 

                lc_result := lc_result || next1;

                next1 := '';

            ELSIF LENGTH(next2) > 0 THEN

                lc_result := lc_result || next2;

                next2 := '';

            ELSE --ln_found = 2 THEN --i < (LENGTH(in_cod_articolo) - 3 - 2) THEN

                  --ln_found := 1;

                next1 := '';

                next2 := '';

                SELECT COUNT(*)

                INTO ln_char_count

                FROM wise01.mc_udp

                WHERE id_udc = in_id_udc

                AND SUBSTR(cod_articolo, i, 3) = SUBSTR(in_cod_articolo, i, 3)

                AND cod_articolo <> in_cod_articolo;

 

                IF ln_char_count = 0 THEN

                    next1 := SUBSTR(in_cod_articolo, i + 1, 1);

                    next2 := SUBSTR(in_cod_articolo, i + 2, 1);

                    lc_result := lc_result || SUBSTR(in_cod_articolo, i, 1);

                ELSE

                    lc_result := lc_result || '_';

                END IF;

            --ELSE

                  --lc_result := lc_result || '_';

            END IF;

        END LOOP;

        RETURN lc_result;

        EXCEPTION

        WHEN OTHERS THEN

            RETURN '<html>'||in_id_udc;

    END EVIDENZIA_CENTRALI;

 

 

 

      FUNCTION EVIDENZIA_ARTICOLO (

        in_id_udc        IN wise01.mc_udp.cod_articolo%TYPE,

        in_cod_articolo  IN wise01.mc_udp.id_udc%TYPE

    )

    RETURN VARCHAR2 IS

 
        ln_len     NUMBER;
        lc_result  VARCHAR2(100);

        lc_part    VARCHAR2(100);

       lc_part2   VARCHAR2(100);

        ln_char_count NUMBER;

 

    BEGIN
         ln_len := LENGTH(in_cod_articolo);
        lc_result := '';

 

 

        

 

        lc_part := ANALIZZA_ARTICOLO(in_id_udc, in_cod_articolo, 1, 1, 2, 1); --1


        IF (lc_part <> '%') THEN
          RETURN  lc_part||CREA_PAD(ln_len -3);
        ELSE 
          lc_part2:= ANALIZZA_ARTICOLO(in_id_udc, in_cod_articolo, -1, 1, 2, 0); --U
        END IF;

        IF (lc_part <> '%') THEN
          RETURN  CREA_PAD(ln_len -3)||lc_part;
        ELSE 
          lc_part := ANALIZZA_ARTICOLO(in_id_udc, in_cod_articolo, 1, 2, 1, 1); --12
          
        END IF;

        IF (lc_part <> '%') THEN
          RETURN lc_part||CREA_PAD(ln_len -3);
        ELSE
           lc_part2 := ANALIZZA_ARTICOLO(in_id_udc, in_cod_articolo, -2, 2, 1, 0); --PU
        END IF;

        IF (lc_part <> '%') THEN
          RETURN  lc_part||CREA_PAD(ln_len -3);
        ELSE 
          lc_PART := ANALIZZA_ARTICOLO(in_id_udc, in_cod_articolo, 1, 3, 0, 1);  --123 
        END IF;

        IF (lc_part <> '%') THEN
          RETURN  lc_part||CREA_PAD(ln_len -3);
        ELSE 
          lc_PART := ANALIZZA_ARTICOLO(in_id_udc, in_cod_articolo, -3, 3, 0, 0);  --TPU
        END IF;

        IF (lc_part <> '%') THEN
          RETURN  CREA_PAD(ln_len -3)||lc_part;
        ELSE 
           lc_PART := ANALIZZA_ARTICOLO_MISTO(in_id_udc, in_cod_articolo, 1, 1, 2    -1, 1, 2);  --1U
        END IF;

        IF (lc_part <> '%') THEN
          RETURN  CREA_PAD(ln_len -3)||lc_part;
        ELSE 
           lc_PART := ANALIZZA_ARTICOLO_MISTO(in_id_udc, in_cod_articolo, 1, 2, 1,    -1, 1, 2);  --12U
        END IF;

        IF (lc_part <> '%') THEN
          RETURN  CREA_PAD(ln_len -3)||lc_part;
        ELSE 
           lc_PART := ANALIZZA_ARTICOLO_MISTO(in_id_udc, in_cod_articolo, 1, 1, 2,    -2, 2, 1);  --1PU
        END IF;

        IF (lc_part <> '%') THEN
          RETURN  CREA_PAD(ln_len -3)||lc_part;
        ELSE 
           RETURN EVIDENZIA_CENTRALI(in_id_udc, in_cod_articolo);  --MISTI
        END IF;

    END EVIDENZIA_ARTICOLO;

 

 

      FUNCTION CREA_PAD (

      in_spazi       NUMBER;

    ) RETURN VARCHAR2 IS

      lc_out   VARCHAR2

    BEGIN

      lc_out := '';

      FOR i IN 1..in_spazi LOOP

            lc_out := lc_out || '_';

        END LOOP;

        RETURN lc_out;

    END CREA_PAD;

 

   FUNCTION ANALIZZA_ARTICOLO_MISTO (

        in_id_udc        IN wise01.mc_udp.cod_articolo%TYPE,

        in_cod_articolo  IN wise01.mc_udp.id_udc%TYPE,

        in_pos_1          VARCHAR2,
        in_len_1           NUMBER,
        in_spazi_1         NUMBER,
     
        in_pos_2          VARCHAR2,
        in_len_2           NUMBER,
        in_spazi_2         NUMBER,

    )

    RETURN VARCHAR2 IS

      lc_spazi_1      VARCHAR2(100);
      lc_spazi_2      VARCHAR2(100);

      ln_char_count NUMBER;

    BEGIN

 

 

        FOR i IN 1..in_spazi_1 LOOP
            lc_spazi_1 := lc_spazi_1||'_';
        END LOOP;
        FOR i IN 1..in_spazi_2 LOOP
            lc_spazi_2 := lc_spazi_2||'_';
        END LOOP;

 

 

 

        SELECT COUNT(*)

        INTO ln_char_count

        FROM wise01.mc_udp

        WHERE id_udc = in_id_udc

        AND SUBSTR(cod_articolo, in_pos_1, in_len_1) = SUBSTR(in_cod_articolo, in_pos_1, in_len_1)
        AND SUBSTR(cod_articolo, in_pos_2, in_len_2) = SUBSTR(in_cod_articolo, in_pos_2, in_len_2)
        AND cod_articolo <> in_cod_articolo;

 

        IF ln_char_count = 0 THEN
                  RETURN (SUBSTR(in_cod_articolo, in_pos_1, in_len_1)||lc_spazi)|| 
                          in_cod_articolo
                         ||(lc_spazi||SUBSTR(in_cod_articolo, in_pos_2, in_len_2));
        ELSE
            lc_spazi := '';
            FOR i IN 1..in_len LOOP
                  lc_spazi := lc_spazi||'_';
            END LOOP;

            RETURN lc_spazi;
        END IF;
    END ANALIZZA_ARTICOLO_MISTO;


 

 

    FUNCTION ANALIZZA_ARTICOLO (

        in_id_udc        IN wise01.mc_udp.cod_articolo%TYPE,

        in_cod_articolo  IN wise01.mc_udp.id_udc%TYPE,

        in_pos           VARCHAR2,

        in_len           NUMBER,

        in_spazi         NUMBER,

        in_after_concat  NUMBER  -- 1 => CONCAT AFTER, 0 CONCAT BEFORE

 

    )

    RETURN VARCHAR2 IS

      lc_spazi      VARCHAR2(100);

      ln_char_count NUMBER;

    BEGIN

 

 

      FOR i IN 1..in_spazi LOOP

            lc_spazi := lc_spazi||'_';

        END LOOP;

 

 

 

        SELECT COUNT(*)

        INTO ln_char_count

        FROM wise01.mc_udp

        WHERE id_udc = in_id_udc

        AND SUBSTR(cod_articolo, in_pos, in_len) = SUBSTR(in_cod_articolo, in_pos, in_len)

        AND cod_articolo <> in_cod_articolo;

 

        IF ln_char_count = 0 THEN

            IF in_after_concat = 1 THEN

                  RETURN (SUBSTR(in_cod_articolo, in_pos, in_len)||lc_spazi);

            ELSE

                  RETURN (lc_spazi||SUBSTR(in_cod_articolo, in_pos, in_len));

            END IF;

        ELSE

 

            /*FOR i IN 1..in_len LOOP

                  lc_spazi := lc_spazi||'_';

            END LOOP;*/

            RETURN '%';

 

            --||lc_spazi;

        END IF;

    END ANALIZZA_ARTICOLO;

 

 

END fca_pck2;
