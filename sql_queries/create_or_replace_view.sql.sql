CREATE OR REPLACE VIEW public.view_preco_insercao AS
SELECT
    pr.preco_id,
    UPPER(TRIM(pr.prc_cod_prod)) AS prc_cod_prod,

  
    (
      NULLIF(
        REPLACE(
          regexp_replace(
            regexp_replace(TRIM(pr.prc_valor), '[^0-9.,-]', '', 'g') ,     
            '([.,])(?=.*[.,])',                                            
            '',
            'g'
          ),
          ',', '.'
        ),
        ''
      )
    )::NUMERIC(10,2) AS prc_valor,

    UPPER(TRIM(pr.prc_moeda)) AS prc_moeda,
    TRIM(pr.prc_desc)         AS prc_desc,

   
    (
      NULLIF(
        REPLACE(
          regexp_replace(
            regexp_replace(TRIM(pr.prc_acres), '[^0-9.,-]', '', 'g'),
            '([.,])(?=.*[.,])',
            '',
            'g'
          ),
          ',', '.'
        ),
        ''
      )
    )::NUMERIC(10,2) AS prc_acres,

    
    (
      NULLIF(
        REPLACE(
          regexp_replace(
            regexp_replace(TRIM(pr.prc_promo), '[^0-9.,-]', '', 'g'),
            '([.,])(?=.*[.,])',
            '',
            'g'
          ),
          ',', '.'
        ),
        ''
      )
    )::NUMERIC(10,2) AS prc_promo,

  
    CASE
      WHEN TRIM(pr.prc_dt_ini_promo) ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_DATE(TRIM(pr.prc_dt_ini_promo), 'YYYY-MM-DD')
      WHEN TRIM(pr.prc_dt_ini_promo) ~ '^\d{4}/\d{2}/\d{2}$' THEN TO_DATE(TRIM(pr.prc_dt_ini_promo), 'YYYY/MM/DD')
      WHEN TRIM(pr.prc_dt_ini_promo) ~ '^\d{4}\.\d{2}\.\d{2}$' THEN TO_DATE(TRIM(pr.prc_dt_ini_promo), 'YYYY.MM.DD')
      WHEN TRIM(pr.prc_dt_ini_promo) ~ '^\d{2}/\d{2}/\d{4}$' THEN TO_DATE(TRIM(pr.prc_dt_ini_promo), 'DD/MM/YYYY')
      WHEN TRIM(pr.prc_dt_ini_promo) ~ '^\d{2}-\d{2}-\d{4}$' THEN TO_DATE(TRIM(pr.prc_dt_ini_promo), 'DD-MM-YYYY')
      WHEN TRIM(pr.prc_dt_ini_promo) ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(TRIM(pr.prc_dt_ini_promo), 'DD.MM.YYYY')
      ELSE NULL
    END AS prc_dt_ini_promo,

    CASE
      WHEN TRIM(pr.prc_dt_fim_promo) ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_DATE(TRIM(pr.prc_dt_fim_promo), 'YYYY-MM-DD')
      WHEN TRIM(pr.prc_dt_fim_promo) ~ '^\d{4}/\d{2}/\d{2}$' THEN TO_DATE(TRIM(pr.prc_dt_fim_promo), 'YYYY/MM/DD')
      WHEN TRIM(pr.prc_dt_fim_promo) ~ '^\d{4}\.\d{2}\.\d{2}$' THEN TO_DATE(TRIM(pr.prc_dt_fim_promo), 'YYYY.MM.DD')
      WHEN TRIM(pr.prc_dt_fim_promo) ~ '^\d{2}/\d{2}/\d{4}$' THEN TO_DATE(TRIM(pr.prc_dt_fim_promo), 'DD/MM/YYYY')
      WHEN TRIM(pr.prc_dt_fim_promo) ~ '^\d{2}-\d{2}-\d{4}$' THEN TO_DATE(TRIM(pr.prc_dt_fim_promo), 'DD-MM-YYYY')
      WHEN TRIM(pr.prc_dt_fim_promo) ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(TRIM(pr.prc_dt_fim_promo), 'DD.MM.YYYY')
      ELSE NULL
    END AS prc_dt_fim_promo,

    CASE
      WHEN TRIM(pr.prc_dt_atual) ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_DATE(TRIM(pr.prc_dt_atual), 'YYYY-MM-DD')
      WHEN TRIM(pr.prc_dt_atual) ~ '^\d{4}/\d{2}/\d{2}$' THEN TO_DATE(TRIM(pr.prc_dt_atual), 'YYYY/MM/DD')
      WHEN TRIM(pr.prc_dt_atual) ~ '^\d{4}\.\d{2}\.\d{2}$' THEN TO_DATE(TRIM(pr.prc_dt_atual), 'YYYY.MM.DD')
      WHEN TRIM(pr.prc_dt_atual) ~ '^\d{2}/\d{2}/\d{4}$' THEN TO_DATE(TRIM(pr.prc_dt_atual), 'DD/MM/YYYY')
      WHEN TRIM(pr.prc_dt_atual) ~ '^\d{2}-\d{2}-\d{4}$' THEN TO_DATE(TRIM(pr.prc_dt_atual), 'DD-MM-YYYY')
      WHEN TRIM(pr.prc_dt_atual) ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(TRIM(pr.prc_dt_atual), 'DD.MM.YYYY')
      ELSE NULL
    END AS prc_dt_atual,

    TRIM(pr.prc_origem)            AS prc_origem,
    UPPER(TRIM(pr.prc_tipo_cli))   AS prc_tipo_cli,
    TRIM(pr.prc_vend_resp)         AS prc_vend_resp,
    TRIM(pr.prc_obs)               AS prc_obs,
    UPPER(TRIM(pr.prc_status))     AS prc_status
FROM public.precos_base pr
WHERE UPPER(TRIM(pr.prc_status)) = 'ATIVO';
