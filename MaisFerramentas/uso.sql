SELECT 
  --==============================
  --Informações de Contato
  --==============================
  tb_data_users.id_tb_data_users,
  tb_data_users.id,
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
  CONCAT(tb_data_users.address_street_1,
  tb_data_users.address_street_2,
  tb_data_users.address_city,
  tb_data_users.address_state,
  tb_data_users.address_country,
  tb_data_users.address_postal_code) complete_address,
  
  --======================================
  --Informações sobre a situação de membro
  --======================================
  --Recomendação
  null is_active,
  null last_atendance_date,
  tb_data_users.temple_recommend_type,
  tb_data_users.temple_recommend_status,
  TO_CHAR(TO_DATE(tb_data_users."templeRecommendExpirationDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "templeRecommendExpirationDateSort",
  --Dizimo
  null is_tithe,
  null last_tithe_date,
  null value_of_last_tithe_date,
  --Chamado
  tb_data_users.callings,
  tb_data_users.callings_with_date_sustained,
  tb_data_users.callings_with_date_sustained_and_set_apart,
  --Ministração
  tb_data_users.has_home_teacher,
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
  -- TO_CHAR(TO_DATE(tb_data_users."sealingToParentsSort", 'YYYYMMDD'), 'YYYY-MM-DD') "sealingToParentsSort",
  tb_data_users."sealingToParentsSort",
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
  --Família
  tb_data_users.household_position,
  tb_data_users.head_of_house,
  tb_data_users.spouse_of_head_of_house,
  tb_data_users.head_of_house_and_spouse,
  --Transferência / Criação do 
  TO_CHAR(TO_DATE(tb_data_users."moveInDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "moveInDateSort",
  
  --Unidade
  tb_data_users.unit,
  --Endereço por partes
  tb_data_users.address_street_1,
  tb_data_users.address_street_2,
  tb_data_users.address_city,
  tb_data_users.address_state,
  tb_data_users.address_country,
  tb_data_users.address_postal_code,
  --Informações de Controle da Tabela
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