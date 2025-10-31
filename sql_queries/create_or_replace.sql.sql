CREATE OR REPLACE VIEW public.view_produto_insercao AS
SELECT
  pb.prod_id,
  TRIM(UPPER(pb.prod_cod))           AS prod_cod,
  INITCAP(TRIM(pb.prod_nome))        AS prod_nome,
  UPPER(TRIM(pb.prod_cat))           AS prod_cat,
  UPPER(TRIM(pb.prod_subcat))        AS prod_subcat,
  TRIM(pb.prod_desc)                 AS prod_desc,
  TRIM(pb.prod_fab)                  AS prod_fab,
  TRIM(pb.prod_mod)                  AS prod_mod,
  TRIM(pb.prod_cor)                  AS prod_cor,
  TRIM(pb.prod_peso)                 AS prod_peso,
  TRIM(pb.prod_larg)                 AS prod_larg,
  TRIM(pb.prod_alt)                  AS prod_alt,
  TRIM(pb.prod_prof)                 AS prod_prof,
  UPPER(TRIM(pb.prod_und))           AS prod_und,
  pb.prod_atv,
  CASE
    WHEN TRIM(pb.prod_dt_cad) ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_DATE(TRIM(pb.prod_dt_cad), 'YYYY-MM-DD')
    WHEN TRIM(pb.prod_dt_cad) ~ '^\d{4}/\d{2}/\d{2}$' THEN TO_DATE(TRIM(pb.prod_dt_cad), 'YYYY/MM/DD')
    WHEN TRIM(pb.prod_dt_cad) ~ '^\d{4}\.\d{2}\.\d{2}$' THEN TO_DATE(TRIM(pb.prod_dt_cad), 'YYYY.MM.DD')
    WHEN TRIM(pb.prod_dt_cad) ~ '^\d{2}/\d{2}/\d{4}$' THEN TO_DATE(TRIM(pb.prod_dt_cad), 'DD/MM/YYYY')
    WHEN TRIM(pb.prod_dt_cad) ~ '^\d{2}-\d{2}-\d{4}$' THEN TO_DATE(TRIM(pb.prod_dt_cad), 'DD-MM-YYYY')
    WHEN TRIM(pb.prod_dt_cad) ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(TRIM(pb.prod_dt_cad), 'DD.MM.YYYY')
    ELSE NULL
  END AS prod_dt_cad
FROM public.produtos_base pb
WHERE pb.prod_atv IS TRUE;
ALTER TABLE public.produto_insercao
ADD COLUMN prod_id BIGINT;

