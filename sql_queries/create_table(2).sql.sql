CREATE TABLE IF NOT EXISTS public.produto_insercao (
  id              BIGSERIAL PRIMARY KEY,
  prod_id         BIGINT,
  prod_cod        VARCHAR(50) UNIQUE NOT NULL,
  prod_nome       TEXT NOT NULL,
  prod_cat        TEXT,
  prod_subcat     TEXT,
  prod_desc       TEXT,
  prod_fab        TEXT,
  prod_mod        TEXT,
  prod_cor        TEXT,
  prod_peso       TEXT,
  prod_larg       TEXT,
  prod_alt        TEXT,
  prod_prof       TEXT,
  prod_und        TEXT,
  prod_atv        BOOLEAN NOT NULL,
  prod_dt_cad     DATE,
  atualizado_em   TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.preco_insercao (
  id               BIGSERIAL PRIMARY KEY,
  preco_id         BIGINT,
  prc_cod_prod     VARCHAR(50) NOT NULL,
  prc_valor        NUMERIC(10,2) NOT NULL,
  prc_moeda        CHAR(3) NOT NULL,
  prc_desc         TEXT,
  prc_acres        NUMERIC(10,2),
  prc_promo        NUMERIC(10,2),
  prc_dt_ini_promo DATE,
  prc_dt_fim_promo DATE,
  prc_dt_atual     DATE,
  prc_origem       TEXT,
  prc_tipo_cli     TEXT,
  prc_vend_resp    TEXT,
  prc_obs          TEXT,
  prc_status       TEXT,
  atualizado_em    TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);


CREATE UNIQUE INDEX IF NOT EXISTS uq_preco_insercao_composto
ON public.preco_insercao (
  prc_cod_prod,
  prc_dt_atual,
  prc_dt_ini_promo,
  prc_dt_fim_promo
);





 	