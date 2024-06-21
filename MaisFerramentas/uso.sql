WITH tb_family AS
(	--Este Select Visa agrupar toda a família sob seu chefe em uma única linha
	SELECT 
		head_of_house, 
		STRING_AGG(full_name || ' ' || household_position, ' ; ') complete_family,
		STRING_AGG(TRIM(SUBSTRING(full_name FROM POSITION(',' IN full_name) + 1)) || ' ' || TRIM(SUBSTRING(full_name FROM 1 FOR POSITION(',' IN full_name) - 1)) || ' ' || household_position, ' ; ') complete_family_formatted
	FROM 
	--Este From lista todos os registros com seus respectivos chefes de família e posição
	(
		SELECT  
			DISTINCT
			full_name,
			head_of_house,
			household_position,
			"birthDateSort",
			CASE 
				WHEN household_position = 'Head of Household' THEN 1
				WHEN household_position = 'Spouse of Head of House' THEN 2
				WHEN household_position = 'Son' THEN 3
				WHEN household_position = 'Daughter' THEN 3
				WHEN household_position = 'Other' THEN 5
			END AS order_household_position
		FROM maisferramentas.tb_data_users
		ORDER BY 
			head_of_house,
			CASE 
				WHEN household_position = 'Head of Household' THEN 1
				WHEN household_position = 'Spouse of Head of House' THEN 2
				WHEN household_position = 'Son' THEN 3
				WHEN household_position = 'Daughter' THEN 3
				WHEN household_position = 'Other' THEN 5
			END, "birthDateSort"
	)
	GROUP BY head_of_house
	ORDER BY head_of_house
)



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
  tb_family.complete_family_formatted,
  tb_family.complete_family,
  

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

  --Transferência / Criação do para a unidade
  TO_CHAR(TO_DATE(tb_data_users."moveInDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') "moveInDateSort",
  --Transferência / Falecimento para fora da unidade
  vw_members_moved_out."moveDate",
  vw_members_moved_out."priorUnit",
  vw_members_moved_out."nextUnitName",
  vw_members_moved_out."nextUnitNumber",
  vw_members_moved_out.deceased,
  --tb_data_users.birth_date ,
  TO_CHAR(TO_DATE(tb_data_users."birthDateSort", 'YYYYMMDD'), 'YYYY-MM-DD') birth_date,
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
  CASE 
    WHEN vw_members_moved_out."moveDate" IS NULL THEN 1 ELSE 0 
  END id_status,
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
LEFT JOIN maisferramentas.vw_members_moved_out vw_members_moved_out 
  ON vw_members_moved_out.name = tb_data_users.full_name
  AND vw_members_moved_out."birthDate" = TO_CHAR(TO_DATE(tb_data_users."birthDateSort", 'YYYYMMDD'), 'YYYY-MM-DD')
LEFT JOIN tb_family ON tb_family.head_of_house = tb_data_users.head_of_house
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