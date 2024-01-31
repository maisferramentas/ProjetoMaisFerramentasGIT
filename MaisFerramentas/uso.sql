-- View: frequencia.vw_frequencia

-- DROP VIEW frequencia.vw_frequencia;

CREATE OR REPLACE VIEW frequencia.vw_frequencia
 AS
 SELECT a.data_frequencia,
    a.id_membro_interno,
    d.nome_interno,
    d.sexo,
    (date_part('year'::text, CURRENT_DATE) - d.ano_do_nascimento::double precision)::integer AS idade,
    a.id_tipo_frequencia,
    f.tipo_frequencia,
    a.status_frequencia,
    a.inserido_em,
    a.inserido_por,
    e.nome_interno AS inserido_por_nome
   FROM frequencia.tb_frequencia a
     JOIN ( SELECT max(b.inserido_em) AS inserido_em,
            b.data_frequencia::date AS data_frequencia,
            b.id_membro_interno
           FROM frequencia.tb_frequencia b
          GROUP BY b.id_membro_interno, (b.data_frequencia::date)) c ON c.id_membro_interno = a.id_membro_interno AND c.inserido_em = a.inserido_em AND c.data_frequencia = a.data_frequencia::date
     JOIN maisferramentas.vw_usuarios d ON d.id_membro_interno = a.id_membro_interno
     JOIN maisferramentas.vw_usuarios e ON e.id_membro_interno = a.inserido_por
     JOIN frequencia.tb_tipo_frequencia f ON f.id_tipo_frequencia = a.id_tipo_frequencia
  ORDER BY a.data_frequencia, d.nome_interno;

ALTER TABLE frequencia.vw_frequencia
    OWNER TO kwjetfdy;

