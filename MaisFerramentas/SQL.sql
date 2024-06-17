SELECT a.data_frequencia,
    a.id_membro_interno,
    d.nome_interno,
	d.sexo,
	date_part('year'::text, CURRENT_DATE) - d.ano_do_nascimento AS idade,
    a.id_tipo_frequencia,
    f.tipo_frequencia,
    a.status_frequencia,
    a.inserido_em,
    a.inserido_por,
    e.nome_interno AS inserido_por_nome
FROM frequencia.tb_frequencia a
JOIN 
( 
	SELECT 
		max(b.inserido_em) AS inserido_em,
		b.data_frequencia::date AS data_frequencia,
		b.id_membro_interno
	FROM frequencia.tb_frequencia b
	GROUP BY b.id_membro_interno, (b.data_frequencia::date)
) c 
	ON c.id_membro_interno = a.id_membro_interno 
	AND c.inserido_em = a.inserido_em AND c.data_frequencia = a.data_frequencia::date
JOIN maisferramentas.tb_membros d ON d.id_membro_interno = a.id_membro_interno
JOIN maisferramentas.tb_membros e ON e.id_membro_interno = a.inserido_por
JOIN frequencia.tb_tipo_Frequencia f ON f.id_tipo_frequencia = a.id_tipo_frequencia
  ORDER BY a.data_frequencia, d.nome_interno;
---------------------------------------------------------------
 SELECT e.data_frequencia,
    e.id_membro_interno,
    e.nome_interno,
    e.sexo,
    e.idade,
    e.id_tipo_frequencia,
    e.tipo_frequencia,
    e.status_frequencia,
    e.inserido_em,
    e.inserido_por,
    e.inserido_por_nome
   FROM ( SELECT row_number() OVER (PARTITION BY b.data_frequencia, a.id_membro_interno ORDER BY b.inserido_em DESC, a.id_membro_interno) AS versao_mais_recente,
            b.data_frequencia,
            a.id_membro_interno,
            a.nome_interno,
            a.sexo,
            date_part('year'::text, CURRENT_DATE) - a.ano_do_nascimento::double precision AS idade,
            b.id_tipo_frequencia,
            c.tipo_frequencia,
            COALESCE(b.status_frequencia, 0::bigint) AS status_frequencia,
            b.inserido_em,
            b.inserido_por,
            d.nome_interno AS inserido_por_nome
           FROM maisferramentas.tb_membros a
             LEFT JOIN frequencia.tb_frequencia b ON a.id_membro_interno = b.id_membro_interno
             LEFT JOIN frequencia.tb_tipo_frequencia c ON b.id_tipo_frequencia = c.id_tipo_frequencia
             LEFT JOIN maisferramentas.tb_membros d ON d.id_membro_interno = b.inserido_por) e
  WHERE e.versao_mais_recente = 1;
  --------------
--Derrubar Conexões
  SELECT * FROM pg_stat_activity
where datname = 'kwjetfdy';

SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE state = 'idle' AND backend_type = 'client backend'
and client_port not in (46698);

SELECT * FROM pg_stat_activity
where datname = 'kwjetfdy';
-----------------------------------------

-- FUNCTION: frequencia.obter_dados_frequencia(date, integer)

-- DROP FUNCTION IF EXISTS frequencia.obter_dados_frequencia(date, integer);

CREATE OR REPLACE FUNCTION frequencia.obter_dados_frequencia(
	data_frequencia_param date,
	id_tipo_frequencia_param integer)
    RETURNS TABLE(data_frequencia date, id_membro_interno bigint, nome_interno character varying, sexo character varying, idade integer, id_tipo_frequencia integer, tipo_frequencia character varying, status_frequencia integer, inserido_em timestamp without time zone, inserido_por bigint, inserido_por_nome character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
        B.data_frequencia::DATE,
        A.id_membro_interno,
        A.nome_interno,
        A.sexo,
        (date_part('year'::text, CURRENT_DATE) - A.ano_do_nascimento::double precision)::integer AS idade,
        B.id_tipo_frequencia::INTEGER,
        B.tipo_frequencia,
        B.status_frequencia::INTEGER,
        B.inserido_em,
        B.inserido_por,
        B.inserido_por_nome
    FROM
        maisferramentas.tb_membros A
    LEFT JOIN
        frequencia.vw_frequencia B
    ON
        A.id_membro_interno = B.id_membro_interno
        AND B.data_frequencia = data_frequencia_param
        AND B.id_tipo_frequencia = id_tipo_frequencia_param;

    -- Retorna o resultado
    RETURN;
END;
$BODY$;

ALTER FUNCTION frequencia.obter_dados_frequencia(date, integer)
    OWNER TO kwjetfdy;
------------------------------------------
-- FUNCTION: frequencia.obter_dados_frequencia(date, integer)

-- DROP FUNCTION IF EXISTS frequencia.obter_dados_frequencia(date, integer);

CREATE OR REPLACE FUNCTION frequencia.obter_dados_frequencia(
	data_frequencia_param date,
	id_tipo_frequencia_param integer)
    RETURNS TABLE(data_frequencia date, id_membro_interno bigint, nome_interno character varying, sexo character varying,ativo integer, idade integer, id_tipo_frequencia integer, tipo_frequencia character varying, status_frequencia integer, inserido_em timestamp without time zone, inserido_por bigint, inserido_por_nome character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
        B.data_frequencia::DATE,
        A.id_membro_interno,
        A.nome_interno,
        A.sexo,
		CASE WHEN C.id_membro_interno IS NOT NULL THEN 1 ELSE 0 END AS ativo,
        (date_part('year'::text, CURRENT_DATE) - A.ano_do_nascimento::double precision)::integer AS idade,
        B.id_tipo_frequencia::INTEGER,
        B.tipo_frequencia,
        B.status_frequencia::INTEGER,
        B.inserido_em,
        B.inserido_por,
        B.inserido_por_nome
    FROM
        maisferramentas.tb_membros A
    LEFT JOIN
        frequencia.vw_frequencia B
    ON
        A.id_membro_interno = B.id_membro_interno
        AND B.data_frequencia = data_frequencia_param
        AND B.id_tipo_frequencia = id_tipo_frequencia_param
	LEFT JOIN (SELECT DISTINCT id_membro_interno
	FROM frequencia.vw_frequencia
	WHERE data_frequencia > current_date - 90
	AND status_frequencia = 1) C ON C.id_membro_interno = A.id_membro_interno

    -- Retorna o resultado
    RETURN;
END;
$BODY$;

ALTER FUNCTION frequencia.obter_dados_frequencia(date, integer)
    OWNER TO kwjetfdy;


----------------------

--SELECT versao_id_membro_interno, id_membro_interno, nome_interno, "nome_de_preferência", nome_completo, "nome_do_cônjuge", "abreviação_da_unidade", aluno_em_potencial_do_instituto, "aluno_em_potencial_do_seminário", "aniversário", ano_do_nascimento, chamados, "chamados_com_as_datas_de_apoio_e_da_designação", chamados_com_data_de_apoio, "chefe_de_família", "chefe_de_família_e_cônjuge", "cônjuge_do_chefe_da_família", data_da_investidura, "data_da_ordenação", "data_de_mudança_para_a_ala", data_de_batismo, "data_de_confirmação", data_de_nascimento, "data_de_validade_da_recomendação_para_o_templo", data_do_casamento, "designação_de_classe", dia_do_nascimento, email_individual, "endereço__cidade", "endereço__código_postal", "endereço__estado_ou_província", "endereço__país", "endereço__rua_1", "endereço__rua_2", estado_civil, "está_frequentando_o_instituto", "está_frequentando_o_seminário", idade, "idioma_da_missão", "irmãos_ministradores", "irmãs_ministradoras", local_de_nascimento, "mês_do_nascimento", nome_de_solteira, "ofício_do_sacerdócio", "país_da_missão", "país_de_nascimento", "posição_na_família", possui_filhos, "possui_irmãos_ministradores", "possui_irmãs_ministradoras", recebeu_investidura, "sacerdócio", "selamento_ao_cônjuge", selamento_aos_pais, sexo, "situação_da_investidura", "situação_de_recomendação_para_o_templo", "situação_do_instituto", "situação_do_seminário", telefone_individual, "tipo_de_recomendação_para_o_templo", unidade, "É_casadoa", "É_converso", "É_divorciado", "É_exmissionário", "É_nascidoa_no_convênio", "É_responsável", "É_selado_aos_pais", "É_seladoa_a_um_cônjuge", "É_seladoa_a_um_cônjuge_anterior", "É_seladoa_ao_cônjuge_atual", "É_solteiro", "É_viúvo", id_perfil, status_usuario, inserido_por, inserido_em
--drop table tb_inalterados
--CREATE TEMPORARY TABLE tb_inalterados AS
--SELECT A.* 
DELETE FROM maisferramentas.tb_usuarios_temp A
USING maisferramentas.VW_usuarios B
WHERE b.nome_interno = a.nome_interno AND
b."nome_de_preferência" = a."nome_de_preferência" AND
b.nome_completo = a.nome_completo AND
b."nome_do_cônjuge" = a."nome_do_cônjuge" AND
b."abreviação_da_unidade" = a."abreviação_da_unidade" AND
b.aluno_em_potencial_do_instituto = a.aluno_em_potencial_do_instituto AND
b."aluno_em_potencial_do_seminário" = a."aluno_em_potencial_do_seminário" AND
b."aniversário" = a."aniversário" AND
b.ano_do_nascimento = a.ano_do_nascimento AND
b.chamados = a.chamados AND
b."chamados_com_as_datas_de_apoio_e_da_designação" = a."chamados_com_as_datas_de_apoio_e_da_designação" AND
b.chamados_com_data_de_apoio = a.chamados_com_data_de_apoio AND
b."chefe_de_família" = a."chefe_de_família" AND
b."chefe_de_família_e_cônjuge" = a."chefe_de_família_e_cônjuge" AND
b."cônjuge_do_chefe_da_família" = a."cônjuge_do_chefe_da_família" AND
b.data_da_investidura = a.data_da_investidura AND
b."data_da_ordenação" = a."data_da_ordenação" AND
b."data_de_mudança_para_a_ala" = a."data_de_mudança_para_a_ala" AND
b.data_de_batismo = a.data_de_batismo AND
b."data_de_confirmação" = a."data_de_confirmação" AND
b.data_de_nascimento = a.data_de_nascimento AND
b."data_de_validade_da_recomendação_para_o_templo" = a."data_de_validade_da_recomendação_para_o_templo" AND
b.data_do_casamento = a.data_do_casamento AND
b."designação_de_classe" = a."designação_de_classe" AND
b.dia_do_nascimento = a.dia_do_nascimento AND
b.email_individual = a.email_individual AND
b."endereço__cidade" = a."endereço__cidade" AND
b."endereço__código_postal" = a."endereço__código_postal" AND
b."endereço__estado_ou_província" = a."endereço__estado_ou_província" AND
b."endereço__país" = a."endereço__país" AND
b."endereço__rua_1" = a."endereço__rua_1" AND
b."endereço__rua_2" = a."endereço__rua_2" AND
b.estado_civil = a.estado_civil AND
b."está_frequentando_o_instituto" = a."está_frequentando_o_instituto" AND
b."está_frequentando_o_seminário" = a."está_frequentando_o_seminário" AND
--b.idade = a.idade AND
b."idioma_da_missão" = a."idioma_da_missão" AND
b."irmãos_ministradores" = a."irmãos_ministradores" AND
b."irmãs_ministradoras" = a."irmãs_ministradoras" AND
b.local_de_nascimento = a.local_de_nascimento AND
b."mês_do_nascimento" = a."mês_do_nascimento" AND
b.nome_de_solteira = a.nome_de_solteira AND
b."ofício_do_sacerdócio" = a."ofício_do_sacerdócio" AND
b."país_da_missão" = a."país_da_missão" AND
b."país_de_nascimento" = a."país_de_nascimento" AND
b."posição_na_família" = a."posição_na_família" AND
b.possui_filhos = a.possui_filhos AND
b."possui_irmãos_ministradores" = a."possui_irmãos_ministradores" AND
b."possui_irmãs_ministradoras" = a."possui_irmãs_ministradoras" AND
b.recebeu_investidura = a.recebeu_investidura AND
b."sacerdócio" = a."sacerdócio" AND
b."selamento_ao_cônjuge" = a."selamento_ao_cônjuge" AND
b.selamento_aos_pais = a.selamento_aos_pais AND
b.sexo = a.sexo AND
b."situação_da_investidura" = a."situação_da_investidura" AND
b."situação_de_recomendação_para_o_templo" = a."situação_de_recomendação_para_o_templo" AND
b."situação_do_instituto" = a."situação_do_instituto" AND
b."situação_do_seminário" = a."situação_do_seminário" AND
b.telefone_individual = a.telefone_individual AND
b."tipo_de_recomendação_para_o_templo" = a."tipo_de_recomendação_para_o_templo" AND
b.unidade = a.unidade AND
b."É_casadoa" = a."É_casadoa" AND
b."É_converso" = a."É_converso" AND
b."É_divorciado" = a."É_divorciado" AND
b."É_exmissionário" = a."É_exmissionário" AND
b."É_nascidoa_no_convênio" = a."É_nascidoa_no_convênio" AND
b."É_responsável" = a."É_responsável" AND
b."É_selado_aos_pais" = a."É_selado_aos_pais" AND
b."É_seladoa_a_um_cônjuge" = a."É_seladoa_a_um_cônjuge" AND
b."É_seladoa_a_um_cônjuge_anterior" = a."É_seladoa_a_um_cônjuge_anterior" AND
b."É_seladoa_ao_cônjuge_atual" = a."É_seladoa_ao_cônjuge_atual" AND
b."É_solteiro" = a."É_solteiro" AND
b."É_viúvo" = a."É_viúvo" 

CREATE TEMPORARY TABLE tb_id_memebro_interno AS
SELECT A.* 
FROM maisferramentas.tb_usuarios_temp A
JOIN maisferramentas.VW_usuarios B
ON 

UPDATE maisferramentas.tb_usuarios_temp A
SET id_membro_interno = b.id_membro_interno
FROM maisferramentas.VW_usuarios B
WHERE
--b.nome_interno = a.nome_interno AND
--b."nome_de_preferência" = a."nome_de_preferência" AND
b.nome_completo = a.nome_completo AND
--b.ano_do_nascimento = a.ano_do_nascimento AND
b."data_de_mudança_para_a_ala" = a."data_de_mudança_para_a_ala" AND
b.data_de_batismo = a.data_de_batismo AND
b."data_de_confirmação" = a."data_de_confirmação" AND
b.data_de_nascimento = a.data_de_nascimento AND
b.dia_do_nascimento = a.dia_do_nascimento AND
b.sexo = a.sexo


INSERT INTO maisferramentas.tb_usuarios(
	 nome_interno, "nome_de_preferência", nome_completo, "nome_do_cônjuge", "abreviação_da_unidade", aluno_em_potencial_do_instituto, "aluno_em_potencial_do_seminário", "aniversário", ano_do_nascimento, chamados, "chamados_com_as_datas_de_apoio_e_da_designação", chamados_com_data_de_apoio, "chefe_de_família", "chefe_de_família_e_cônjuge", "cônjuge_do_chefe_da_família", data_da_investidura, "data_da_ordenação", "data_de_mudança_para_a_ala", data_de_batismo, "data_de_confirmação", data_de_nascimento, "data_de_validade_da_recomendação_para_o_templo", data_do_casamento, "designação_de_classe", dia_do_nascimento, email_individual, "endereço__cidade", "endereço__código_postal", "endereço__estado_ou_província", "endereço__país", "endereço__rua_1", "endereço__rua_2", estado_civil, "está_frequentando_o_instituto", "está_frequentando_o_seminário", idade, "idioma_da_missão", "irmãos_ministradores", "irmãs_ministradoras", local_de_nascimento, "mês_do_nascimento", nome_de_solteira, "ofício_do_sacerdócio", "país_da_missão", "país_de_nascimento", "posição_na_família", possui_filhos, "possui_irmãos_ministradores", "possui_irmãs_ministradoras", recebeu_investidura, "sacerdócio", "selamento_ao_cônjuge", selamento_aos_pais, sexo, "situação_da_investidura", "situação_de_recomendação_para_o_templo", "situação_do_instituto", "situação_do_seminário", telefone_individual, "tipo_de_recomendação_para_o_templo", unidade, "É_casadoa", "É_converso", "É_divorciado", "É_exmissionário", "É_nascidoa_no_convênio", "É_responsável", "É_selado_aos_pais", "É_seladoa_a_um_cônjuge", "É_seladoa_a_um_cônjuge_anterior", "É_seladoa_ao_cônjuge_atual", "É_solteiro", "É_viúvo", id_perfil, status_usuario, inserido_por, inserido_em)

SELECT nome_interno, "nome_de_preferência", nome_completo, "nome_do_cônjuge", "abreviação_da_unidade", aluno_em_potencial_do_instituto, "aluno_em_potencial_do_seminário", "aniversário", ano_do_nascimento, chamados, "chamados_com_as_datas_de_apoio_e_da_designação", chamados_com_data_de_apoio, "chefe_de_família", "chefe_de_família_e_cônjuge", "cônjuge_do_chefe_da_família", data_da_investidura, "data_da_ordenação", "data_de_mudança_para_a_ala", data_de_batismo, "data_de_confirmação", data_de_nascimento, "data_de_validade_da_recomendação_para_o_templo", data_do_casamento, "designação_de_classe", dia_do_nascimento, email_individual, "endereço__cidade", "endereço__código_postal", "endereço__estado_ou_província", "endereço__país", "endereço__rua_1", "endereço__rua_2", estado_civil, "está_frequentando_o_instituto", "está_frequentando_o_seminário", idade, "idioma_da_missão", "irmãos_ministradores", "irmãs_ministradoras", local_de_nascimento, "mês_do_nascimento", nome_de_solteira, "ofício_do_sacerdócio", "país_da_missão", "país_de_nascimento", "posição_na_família", possui_filhos, "possui_irmãos_ministradores", "possui_irmãs_ministradoras", recebeu_investidura, "sacerdócio", "selamento_ao_cônjuge", selamento_aos_pais, sexo, "situação_da_investidura", "situação_de_recomendação_para_o_templo", "situação_do_instituto", "situação_do_seminário", telefone_individual, "tipo_de_recomendação_para_o_templo", unidade, "É_casadoa", "É_converso", "É_divorciado", "É_exmissionário", "É_nascidoa_no_convênio", "É_responsável", "É_selado_aos_pais", "É_seladoa_a_um_cônjuge", "É_seladoa_a_um_cônjuge_anterior", "É_seladoa_ao_cônjuge_atual", "É_solteiro", "É_viúvo", 1, 1, 90, CURRENT_TIMESTAMP
FROM maisferramentas.tb_usuarios_temp WHERE id_membro_interno is null

UPDATE maisferramentas.tb_usuarios
SET id_membro_interno = versao_id_membro_interno
WHERE id_membro_interno is null


UPDATE maisferramentas.tb_usuarios_temp A
SET id_membro_interno = b.id_membro_interno
FROM maisferramentas.VW_usuarios B
WHERE
--b.nome_interno = a.nome_interno AND
--b."nome_de_preferência" = a."nome_de_preferência" AND
b.nome_completo = a.nome_completo AND
--b.ano_do_nascimento = a.ano_do_nascimento AND
b."data_de_mudança_para_a_ala" = a."data_de_mudança_para_a_ala" AND
b.data_de_batismo = a.data_de_batismo AND
b."data_de_confirmação" = a."data_de_confirmação" AND
b.data_de_nascimento = a.data_de_nascimento AND
b.dia_do_nascimento = a.dia_do_nascimento AND
b.sexo = a.sexo AND
a.id_membro_interno is null


INSERT INTO maisferramentas.tb_usuarios(
	 id_membro_interno, nome_interno, "nome_de_preferência", nome_completo, "nome_do_cônjuge", "abreviação_da_unidade", aluno_em_potencial_do_instituto, "aluno_em_potencial_do_seminário", "aniversário", ano_do_nascimento, chamados, "chamados_com_as_datas_de_apoio_e_da_designação", chamados_com_data_de_apoio, "chefe_de_família", "chefe_de_família_e_cônjuge", "cônjuge_do_chefe_da_família", data_da_investidura, "data_da_ordenação", "data_de_mudança_para_a_ala", data_de_batismo, "data_de_confirmação", data_de_nascimento, "data_de_validade_da_recomendação_para_o_templo", data_do_casamento, "designação_de_classe", dia_do_nascimento, email_individual, "endereço__cidade", "endereço__código_postal", "endereço__estado_ou_província", "endereço__país", "endereço__rua_1", "endereço__rua_2", estado_civil, "está_frequentando_o_instituto", "está_frequentando_o_seminário", idade, "idioma_da_missão", "irmãos_ministradores", "irmãs_ministradoras", local_de_nascimento, "mês_do_nascimento", nome_de_solteira, "ofício_do_sacerdócio", "país_da_missão", "país_de_nascimento", "posição_na_família", possui_filhos, "possui_irmãos_ministradores", "possui_irmãs_ministradoras", recebeu_investidura, "sacerdócio", "selamento_ao_cônjuge", selamento_aos_pais, sexo, "situação_da_investidura", "situação_de_recomendação_para_o_templo", "situação_do_instituto", "situação_do_seminário", telefone_individual, "tipo_de_recomendação_para_o_templo", unidade, "É_casadoa", "É_converso", "É_divorciado", "É_exmissionário", "É_nascidoa_no_convênio", "É_responsável", "É_selado_aos_pais", "É_seladoa_a_um_cônjuge", "É_seladoa_a_um_cônjuge_anterior", "É_seladoa_ao_cônjuge_atual", "É_solteiro", "É_viúvo", id_perfil, status_usuario, inserido_por, inserido_em)
	 

SELECT A.id_membro_interno, A.nome_interno, A."nome_de_preferência", A.nome_completo, A."nome_do_cônjuge", A."abreviação_da_unidade", A.aluno_em_potencial_do_instituto, A."aluno_em_potencial_do_seminário", A."aniversário", A.ano_do_nascimento, A.chamados, A."chamados_com_as_datas_de_apoio_e_da_designação", A.chamados_com_data_de_apoio, A."chefe_de_família", A."chefe_de_família_e_cônjuge", A."cônjuge_do_chefe_da_família", A.data_da_investidura, A."data_da_ordenação", A."data_de_mudança_para_a_ala", A.data_de_batismo, A."data_de_confirmação", A.data_de_nascimento, A."data_de_validade_da_recomendação_para_o_templo", A.data_do_casamento, A."designação_de_classe", A.dia_do_nascimento, A.email_individual, A."endereço__cidade", A."endereço__código_postal", A."endereço__estado_ou_província", A."endereço__país", A."endereço__rua_1", A."endereço__rua_2", A.estado_civil, A."está_frequentando_o_instituto", A."está_frequentando_o_seminário", A.idade, A."idioma_da_missão", A."irmãos_ministradores", A."irmãs_ministradoras", A.local_de_nascimento, A."mês_do_nascimento", A.nome_de_solteira, A."ofício_do_sacerdócio", A."país_da_missão", A."país_de_nascimento", A."posição_na_família", A.possui_filhos, A."possui_irmãos_ministradores", A."possui_irmãs_ministradoras", A.recebeu_investidura, A."sacerdócio", A."selamento_ao_cônjuge", A.selamento_aos_pais, A.sexo, A."situação_da_investidura", A."situação_de_recomendação_para_o_templo", A."situação_do_instituto", A."situação_do_seminário", A.telefone_individual, A."tipo_de_recomendação_para_o_templo", A.unidade, A."É_casadoa", A."É_converso", A."É_divorciado", A."É_exmissionário", A."É_nascidoa_no_convênio", A."É_responsável", A."É_selado_aos_pais", A."É_seladoa_a_um_cônjuge", A."É_seladoa_a_um_cônjuge_anterior", A."É_seladoa_ao_cônjuge_atual", A."É_solteiro", A."É_viúvo", B.id_perfil, B.status_usuario, B.inserido_por, B.inserido_em
FROM maisferramentas.tb_usuarios_temp A
JOIN maisferramentas.vw_usuarios B ON A.id_membro_interno = B.id_membro_interno
WHERE A.id_membro_interno is NOT null


INSERT INTO maisferramentas.tb_usuarios(
	 id_membro_interno, nome_interno, "nome_de_preferência", nome_completo, "nome_do_cônjuge", "abreviação_da_unidade", aluno_em_potencial_do_instituto, "aluno_em_potencial_do_seminário", "aniversário", ano_do_nascimento, chamados, "chamados_com_as_datas_de_apoio_e_da_designação", chamados_com_data_de_apoio, "chefe_de_família", "chefe_de_família_e_cônjuge", "cônjuge_do_chefe_da_família", data_da_investidura, "data_da_ordenação", "data_de_mudança_para_a_ala", data_de_batismo, "data_de_confirmação", data_de_nascimento, "data_de_validade_da_recomendação_para_o_templo", data_do_casamento, "designação_de_classe", dia_do_nascimento, email_individual, "endereço__cidade", "endereço__código_postal", "endereço__estado_ou_província", "endereço__país", "endereço__rua_1", "endereço__rua_2", estado_civil, "está_frequentando_o_instituto", "está_frequentando_o_seminário", idade, "idioma_da_missão", "irmãos_ministradores", "irmãs_ministradoras", local_de_nascimento, "mês_do_nascimento", nome_de_solteira, "ofício_do_sacerdócio", "país_da_missão", "país_de_nascimento", "posição_na_família", possui_filhos, "possui_irmãos_ministradores", "possui_irmãs_ministradoras", recebeu_investidura, "sacerdócio", "selamento_ao_cônjuge", selamento_aos_pais, sexo, "situação_da_investidura", "situação_de_recomendação_para_o_templo", "situação_do_instituto", "situação_do_seminário", telefone_individual, "tipo_de_recomendação_para_o_templo", unidade, "É_casadoa", "É_converso", "É_divorciado", "É_exmissionário", "É_nascidoa_no_convênio", "É_responsável", "É_selado_aos_pais", "É_seladoa_a_um_cônjuge", "É_seladoa_a_um_cônjuge_anterior", "É_seladoa_ao_cônjuge_atual", "É_solteiro", "É_viúvo", id_perfil, status_usuario, inserido_por, inserido_em)
	 
SELECT A.id_membro_interno, A.nome_interno, A."nome_de_preferência", A.nome_completo, A."nome_do_cônjuge", A."abreviação_da_unidade", A.aluno_em_potencial_do_instituto, A."aluno_em_potencial_do_seminário", A."aniversário", A.ano_do_nascimento, A.chamados, A."chamados_com_as_datas_de_apoio_e_da_designação", A.chamados_com_data_de_apoio, A."chefe_de_família", A."chefe_de_família_e_cônjuge", A."cônjuge_do_chefe_da_família", A.data_da_investidura, A."data_da_ordenação", A."data_de_mudança_para_a_ala", A.data_de_batismo, A."data_de_confirmação", A.data_de_nascimento, A."data_de_validade_da_recomendação_para_o_templo", A.data_do_casamento, A."designação_de_classe", A.dia_do_nascimento, A.email_individual, A."endereço__cidade", A."endereço__código_postal", A."endereço__estado_ou_província", A."endereço__país", A."endereço__rua_1", A."endereço__rua_2", A.estado_civil, A."está_frequentando_o_instituto", A."está_frequentando_o_seminário", A.idade, A."idioma_da_missão", A."irmãos_ministradores", A."irmãs_ministradoras", A.local_de_nascimento, A."mês_do_nascimento", A.nome_de_solteira, A."ofício_do_sacerdócio", A."país_da_missão", A."país_de_nascimento", A."posição_na_família", A.possui_filhos, A."possui_irmãos_ministradores", A."possui_irmãs_ministradoras", A.recebeu_investidura, A."sacerdócio", A."selamento_ao_cônjuge", A.selamento_aos_pais, A.sexo, A."situação_da_investidura", A."situação_de_recomendação_para_o_templo", A."situação_do_instituto", A."situação_do_seminário", A.telefone_individual, A."tipo_de_recomendação_para_o_templo", A.unidade, A."É_casadoa", A."É_converso", A."É_divorciado", A."É_exmissionário", A."É_nascidoa_no_convênio", A."É_responsável", A."É_selado_aos_pais", A."É_seladoa_a_um_cônjuge", A."É_seladoa_a_um_cônjuge_anterior", A."É_seladoa_ao_cônjuge_atual", A."É_solteiro", A."É_viúvo", A.id_perfil, 0, 90, current_timestamp
FROM maisferramentas.vw_usuarios A
LEFT JOIN maisferramentas.tb_usuarios_temp B ON A.id_membro_interno = B.id_membro_interno
WHERE B.id_membro_interno is null

---
vw_participants
SELECT 
	id_tb_participants, 
	name, 
	age, 
	A."transactionParticipantId", 
	"membershipId",
    "unitNumber", 
	member, 
	A.inserted_date, 
	inserted_by
FROM maisferramentas.tb_participants A
INNER JOIN 
	(
		SELECT 
			"transactionParticipantId", 
			MAX(inserted_date) inserted_date
		FROM maisferramentas.tb_participants 
		GROUP BY "transactionParticipantId"
	) B
ON A."transactionParticipantId" = B."transactionParticipantId"
AND A.inserted_date = B.inserted_date;
----
vw_data_users
SELECT 
  --======================================
  --Informações de Contato
  --======================================
  tb_data_users.id_tb_data_users,
  tb_data_users.id,
  vw_participants."transactionParticipantId",
  vw_participants."membershipId",
  TRIM(SUBSTRING(full_name FROM POSITION(',' IN full_name) + 1)) || ' ' || TRIM(SUBSTRING(full_name FROM 1 FOR POSITION(',' IN full_name) - 1)) AS full_name_formatted,
  tb_data_users.full_name,
  tb_data_users.gender,
  EXTRACT(YEAR FROM AGE(TO_DATE("birthDateSort", 'YYYYMMDD'))) age,
  --Organization 
  CASE 
    WHEN (SELECT EXTRACT(YEAR FROM CURRENT_DATE) - tb_data_users.birth_year::INTEGER) < 12 THEN 'Primary'
    WHEN EXTRACT(YEAR FROM AGE(TO_DATE("birthDateSort", 'YYYYMMDD'))) >= 18 AND tb_data_users.gender = 'F' THEN 'Relief Society'
    WHEN EXTRACT(YEAR FROM AGE(TO_DATE("birthDateSort", 'YYYYMMDD'))) >= 18 AND tb_data_users.gender = 'M' THEN 'Elders Quorum'
    WHEN tb_data_users.gender = 'M' THEN 'Aaronic Priesthood Quorum'
    WHEN tb_data_users.gender = 'F' THEN 'Young Women'
  END AS organization,
  tb_data_users.individual_phone,
  tb_data_users.individual_email,
  --Endereço Completo
  CONCAT(tb_data_users.address_street_1, ' ',
  tb_data_users.address_street_2, ' ',
  tb_data_users.address_city, ' ',
  tb_data_users.address_state, ' ',
  tb_data_users.address_country, ' ',
  tb_data_users.address_postal_code) complete_address,
  --Família
  CASE 
    WHEN tb_data_users.household_position = 'Head of Household' THEN 1
    WHEN tb_data_users.household_position = 'Spouse of Head of House' THEN 2
    WHEN tb_data_users.household_position = 'Son' THEN 3
    WHEN tb_data_users.household_position = 'Daughter' THEN 4
    WHEN tb_data_users.household_position = 'Other' THEN 5
  END AS order_household_position,
  tb_data_users.household_position,
  TRIM(SUBSTRING(tb_data_users.head_of_house FROM POSITION(',' IN tb_data_users.head_of_house) + 1)) || ' ' || TRIM(SUBSTRING(tb_data_users.head_of_house FROM 1 FOR POSITION(',' IN tb_data_users.head_of_house) - 1)) AS head_of_house_formatted,
  tb_data_users.head_of_house,
  TRIM(SUBSTRING(tb_data_users.spouse_of_head_of_house FROM POSITION(',' IN tb_data_users.spouse_of_head_of_house) + 1)) || ' ' || TRIM(SUBSTRING(tb_data_users.spouse_of_head_of_house FROM 1 FOR POSITION(',' IN tb_data_users.spouse_of_head_of_house) - 1)) AS spouse_of_head_of_house_formatted,
  tb_data_users.spouse_of_head_of_house,
  TRIM(SUBSTRING(tb_data_users.head_of_house_and_spouse FROM POSITION(',' IN tb_data_users.head_of_house_and_spouse) + 1)) || ' ' || TRIM(SUBSTRING(tb_data_users.head_of_house_and_spouse FROM 1 FOR POSITION(',' IN tb_data_users.head_of_house_and_spouse) - 1)) AS head_of_house_and_spouse_formatted,
  tb_data_users.head_of_house_and_spouse,
  
  --======================================
  --Informações sobre a situação de membro
  --======================================
  --Recomendação
  null is_active,
  null last_atendance_date,
  tb_data_users.temple_recommend_type,
  tb_data_users.temple_recommend_status,
  TO_CHAR(TO_DATE(tb_data_users."templeRecommendExpirationDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "templeRecommendExpirationDateSort",
  --Chamado
  -- tb_data_users.callings,
  -- tb_data_users.callings_with_date_sustained,
  regexp_replace(
    regexp_replace(
        callings_with_date_sustained_and_set_apart,
        E'<span class="custom-report-position">(.*?)</span>',
        E'\\1',
        'g' -- Aplica a substituição globalmente em toda a string
    ),
    E'</span>',
    ' / ',
    'g' -- Remove todas as tags de fechamento span restantes
  ) AS callings_with_date_sustained_and_set_apart_formatted,
  tb_data_users.callings_with_date_sustained_and_set_apart,
  --Ministração
  tb_data_users.has_home_teacher,
  array_to_string(
      ARRAY(
          SELECT 
              -- Reorganizando "Sobrenome, Nome" para "Nome Sobrenome"
              -- Captura partes do nome considerando possíveis múltiplos espaços
              regexp_replace(
                  trim(name_part), 
                  '([^,]+), (.+)',
                  E'\\2 \\1'
              )
          FROM unnest(
              string_to_array(home_teachers, ' / ')
          ) AS name_part
      ),
      ' / '
  ) AS home_teachers_formatted,
  tb_data_users.home_teachers,
  tb_data_users.has_visiting_teachers,
  tb_data_users.visiting_teachers,
  --Seminário
  tb_data_users.potential_seminary_student,
  tb_data_users.is_attending_seminary,
  tb_data_users.seminary_status,
  --Instituto
  tb_data_users.potential_institute_student,
  tb_data_users.is_attending_institute,
  tb_data_users.institute_status,
  tb_data_users.class_assignment,

  --======================================
  --Informações históricas do Membro
  --======================================
  --Nascimento
  TO_CHAR(TO_DATE(tb_data_users."birthDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "birthDateSort",
  tb_data_users.birthplace,
  tb_data_users.birth_country,
  --Selamento aos Pais
  tb_data_users.is_sealed_to_parents,
  CASE
    WHEN tb_data_users."sealingToParentsSort" ~ '^[0-9]{8}$' THEN
      TO_CHAR(TO_DATE(tb_data_users."sealingToParentsSort", 'YYYYMMDD'), 'YYYY-MM-DD')
    ELSE
      tb_data_users."sealingToParentsSort"
  END AS "sealingToParentsSort",
  --Batismo e Confirmação
  tb_data_users.is_convert,
  TO_CHAR(TO_DATE(tb_data_users."baptismDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "baptismDateSort",
  TO_CHAR(TO_DATE(tb_data_users."confirmationDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "confirmationDateSort",
  
  --Sacerdócio
  tb_data_users.priesthood,
  tb_data_users.priesthood_office,
  TO_CHAR(TO_DATE(tb_data_users."ordainedDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "ordainedDateSort",
  
  --Investidura
  tb_data_users.is_endowed,
  tb_data_users.endowment_status,
  TO_CHAR(TO_DATE(tb_data_users."endowmentDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "endowmentDateSort",
  
  --Missão
  tb_data_users.is_returned_missionary,
  tb_data_users.mission_country,
  tb_data_users.mission_language,
  --Casamento
  tb_data_users.is_single,
  tb_data_users.is_married,
  tb_data_users.marriage_status,
  TRIM(SUBSTRING(tb_data_users.spouse_name FROM POSITION(',' IN tb_data_users.spouse_name) + 1)) || ' ' || TRIM(SUBSTRING(tb_data_users.spouse_name FROM 1 FOR POSITION(',' IN tb_data_users.spouse_name) - 1)) AS spouse_name_formatted,
  tb_data_users.spouse_name,
  TO_CHAR(TO_DATE(tb_data_users."marriageDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "marriageDateSort",
  
  --Selamento
  tb_data_users.is_sealed_to_a_spouse,
  tb_data_users.is_sealed_to_current_spouse,
  TO_CHAR(TO_DATE(tb_data_users."sealingToSpouseSort", 'YYYYMMDD'), 'YYYY-MM-DD') "sealingToSpouseSort",
  -- tb_data_users."sealingToSpouseSort",
  
  --divórcio
  tb_data_users.is_divorced,
  tb_data_users.is_sealed_to_prior_spouse,
  --Filhos
  tb_data_users.has_children,
  tb_data_users.is_accountable,
  --Transferência / Criação do 
  TO_CHAR(TO_DATE(tb_data_users."moveInDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "moveInDateSort",
  
  --Unidade
  vw_participants."unitNumber",
  tb_data_users.unit,
  --Endereço por partes
  tb_data_users.address_street_1,
  tb_data_users.address_street_2,
  tb_data_users.address_city,
  tb_data_users.address_state,
  tb_data_users.address_country,
  tb_data_users.address_postal_code,
  --Informações de Controle da Tabela
  IIF(tb_max_inserted_date.inserted_date = tb_data_users.inserted_date;1;0) id_status,
  tb_data_users.inserted_date,
  tb_data_users.inserted_by
FROM maisferramentas.tb_data_users
INNER JOIN 
(
  SELECT 
    tb_data_users_1.id,
    max(tb_data_users_1.inserted_date) AS inserted_date
  FROM maisferramentas.tb_data_users tb_data_users_1
  GROUP BY tb_data_users_1.id
) registro 
  ON registro.id = tb_data_users.id AND registro.inserted_date = tb_data_users.inserted_date
LEFT JOIN maisferramentas.vw_participants vw_participants 
  ON vw_participants.name = tb_data_users.full_name
LEFT JOIN 
  (
    SELECT max(tb_data_users_1.inserted_date) inserted_date 
    FROM maisferramentas.tb_data_users tb_data_users_1
  ) tb_max_inserted_date 
  ON tb_max_inserted_date.inserted_date = tb_max_inserted_date.inserted_date
ORDER BY TRIM(SUBSTRING(full_name FROM POSITION(',' IN full_name) + 1)) || ' ' || TRIM(SUBSTRING(full_name FROM 1 FOR POSITION(',' IN full_name) - 1))
/*
--======================
--Colunas Não Utilizadas
--======================
  -- tb_data_users.age,
  -- tb_data_users.birth_year,
  -- tb_data_users."birthMonthSort",
  -- tb_data_users.birth_day,
  -- tb_data_users.birthday,
  -- tb_data_users.birth_date,
  -- tb_data_users.birth_month,
  -- tb_data_users."birthDaySort",
  -- tb_data_users."fullNameSort",
  -- tb_data_users."preferredNameSort",
  -- tb_data_users.preferred_name,
  -- tb_data_users."ageSort",
  -- tb_data_users.temple_recommend_expiration_date,
  -- tb_data_users.sealing_to_parents,
  -- tb_data_users.baptism_date,
  -- tb_data_users.confirmation_date,
  -- tb_data_users.ordination_date,
  -- tb_data_users."priesthoodOfficeSort",
  -- tb_data_users.endowment_date,
  -- tb_data_users.marriage_date,
  -- tb_data_users.sealing_to_spouse,
  -- tb_data_users."spouseNameSort",
  -- tb_data_users."spouseOfHeadOfHouseSort",
  -- tb_data_users."headOfHouseAndSpouseSort",
  -- tb_data_users."headOfHouseSort",
  -- tb_data_users.move_in_date,
  -- tb_data_users."groupByUnitName",
  -- tb_data_users.unit_abbreviation,
  -- tb_data_users.is_bic,
  -- tb_data_users.maiden_name,
  -- tb_data_users."maidenNameSort",
  -- tb_data_users.is_widowed,
*/


----
SELECT 
	MAX(data_frequencia) data_frequencia,
	id_membro_interno,   
	CASE WHEN data_frequencia::DATE <= (CURRENT_DATE) THEN 0 ELSE 1 END AS ativo 
FROM frequencia.vw_frequencia
WHERE status_frequencia =1
GROUP BY id_membro_interno, CASE WHEN data_frequencia::DATE <= CURRENT_DATE THEN 0 ELSE 1 END

-- View: aniversariantes.vw_aniversariantes

-- DROP VIEW aniversariantes.vw_aniversariantes;

CREATE OR REPLACE VIEW aniversariantes.vw_aniversariantes
 AS
 WITH aniversariantes AS (
         SELECT vw_usuarios.id_membro_interno,
            vw_usuarios.nome_interno,
            vw_usuarios.organizacao,
            vw_usuarios.ano_do_nascimento,
                CASE
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'jan'::text THEN '01'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'fev'::text THEN '02'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'mar'::text THEN '03'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'abr'::text THEN '04'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'mai'::text THEN '05'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'jun'::text THEN '06'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'jul'::text THEN '07'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'ago'::text THEN '08'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'set'::text THEN '09'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'out'::text THEN '10'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'nov'::text THEN '11'::text
                    WHEN vw_usuarios."mês_do_nascimento"::text = 'dez'::text THEN '12'::text
                    ELSE '01'::text
                END AS mes_aniversario,
                CASE
                    WHEN COALESCE(vw_usuarios.dia_do_nascimento, 1::bigint)::integer < 10 THEN concat('0', COALESCE(vw_usuarios.dia_do_nascimento, 1::bigint))
                    ELSE vw_usuarios.dia_do_nascimento::text
                END AS dia_aniversario,
            vw_usuarios.idade,
            vw_usuarios.telefone_individual,
            concat(vw_usuarios."endereço__rua_1", ' ', vw_usuarios."endereço__rua_2", ' ', vw_usuarios."endereço__cidade", ' ', vw_usuarios."endereço__estado_ou_província", ' ', vw_usuarios."endereço__país", ' ', vw_usuarios."endereço__código_postal") AS endereco,
            vw_usuarios.sexo
           FROM maisferramentas.vw_usuarios
        )
 SELECT id_membro_interno,
    nome_interno,
    organizacao,
    ano_do_nascimento,
    mes_aniversario,
    dia_aniversario,
    idade,
    telefone_individual,
    endereco,
    concat(ano_do_nascimento, '-', mes_aniversario, '-', dia_aniversario) AS "data_aniversário",
    sexo
   FROM aniversariantes
  ORDER BY mes_aniversario, dia_aniversario, nome_interno;

ALTER TABLE aniversariantes.vw_aniversariantes
    OWNER TO postgres;

