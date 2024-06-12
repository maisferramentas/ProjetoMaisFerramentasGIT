
from .utils import *
from MaisFerramentas.models import maisferramentas
from MaisFerramentas.models import models
from .views import def_usuario_logado
from .view_access_lcr import access_lcr
from bs4 import BeautifulSoup

def update_data_user(request):
    url = 'https://lcr.churchofjesuschrist.org/api/report/custom-reports/run-report/45c90fc8-f097-4fa9-9ea6-151956b0d5af?lang=eng'
    
    driver = access_lcr()
    
    driver.get(url)
    WebDriverWait(driver, 20).until(EC.url_contains('lcr.churchofjesuschrist.org'))
    
    # Extrair o HTML da página
    html_content = driver.page_source

    print('link acessado com sucesso')
    print("finalizando processo.")

    # Usar BeautifulSoup para analisar o HTML e encontrar o JSON
    soup = BeautifulSoup(html_content, 'html.parser')
    pre_tag = soup.find('pre')
    json_text = pre_tag.text
    data = json.loads(json_text)
    
    # Acessar o objeto membros dentro do JSON
    data_user = data.get("members", [])

    data_user = json.loads(json.dumps(data_user))

    inserido_por = models.model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('id_membro_interno', flat=True).first()
    inserido_em=timezone.now().strftime('%Y-%m-%d %H:%M:%S.%f')

    for item in data_user:
        tb_data_users = maisferramentas.tb_data_users(
            marriage_status=item.get('MARRIAGE_STATUS'),
            spouseOfHeadOfHouseSort=item.get('spouseOfHeadOfHouseSort'),
            birth_year=item.get('BIRTH_YEAR'),
            temple_recommend_type=item.get('TEMPLE_RECOMMEND_TYPE'),
            mission_language=item.get('MISSION_LANGUAGE'),
            is_bic=item.get('IS_BIC'),
            visiting_teachers=item.get('VISITING_TEACHERS'),
            moveInDateSort=item.get('moveInDateSort'),
            ageSort=item.get('ageSort'),
            temple_recommend_status=item.get('TEMPLE_RECOMMEND_STATUS'),
            potential_institute_student=item.get('POTENTIAL_INSTITUTE_STUDENT'),
            spouse_of_head_of_house=item.get('SPOUSE_OF_HEAD_OF_HOUSE'),
            is_sealed_to_parents=item.get('IS_SEALED_TO_PARENTS'),
            priesthoodOfficeSort=item.get('priesthoodOfficeSort'),
            templeRecommendExpirationDateSort=item.get('templeRecommendExpirationDateSort'),
            birthMonthSort=item.get('birthMonthSort'),
            is_sealed_to_a_spouse=item.get('IS_SEALED_TO_A_SPOUSE'),
            is_endowed=item.get('IS_ENDOWED'),
            sealing_to_spouse=item.get('SEALING_TO_SPOUSE'),
            sealingToSpouseSort=item.get('sealingToSpouseSort'),
            birth_date=item.get('BIRTH_DATE'),
            maiden_name=item.get('MAIDEN_NAME'),
            institute_status=item.get('INSTITUTE_STATUS'),
            is_sealed_to_current_spouse=item.get('IS_SEALED_TO_CURRENT_SPOUSE'),
            has_visiting_teachers=item.get('HAS_VISITING_TEACHERS'),
            id=item.get('id'),
            priesthood=item.get('PRIESTHOOD'),
            birthday=item.get('BIRTHDAY'),
            is_divorced=item.get('IS_DIVORCED'),
            unit=item.get('UNIT'),
            sealing_to_parents=item.get('SEALING_TO_PARENTS'),
            callings_with_date_sustained_and_set_apart=item.get('CALLINGS_WITH_DATE_SUSTAINED_AND_SET_APART'),
            individual_phone=item.get('INDIVIDUAL_PHONE'),
            birth_country=item.get('BIRTH_COUNTRY'),
            confirmation_date=item.get('CONFIRMATION_DATE'),
            temple_recommend_expiration_date=item.get('TEMPLE_RECOMMEND_EXPIRATION_DATE'),
            birthplace=item.get('BIRTHPLACE'),
            birth_month=item.get('BIRTH_MONTH'),
            endowment_status=item.get('ENDOWMENT_STATUS'),
            maidenNameSort=item.get('maidenNameSort'),
            sealingToParentsSort=item.get('sealingToParentsSort'),
            unit_abbreviation=item.get('UNIT_ABBREVIATION'),
            head_of_house_and_spouse=item.get('HEAD_OF_HOUSE_AND_SPOUSE'),
            is_married=item.get('IS_MARRIED'),
            class_assignment=item.get('CLASS_ASSIGNMENT'),
            seminary_status=item.get('SEMINARY_STATUS'),
            individual_email=item.get('INDIVIDUAL_EMAIL'),
            is_single=item.get('IS_SINGLE'),
            callings_with_date_sustained=item.get('CALLINGS_WITH_DATE_SUSTAINED'),
            is_widowed=item.get('IS_WIDOWED'),
            groupByUnitName=item.get('groupByUnitName'),
            is_sealed_to_prior_spouse=item.get('IS_SEALED_TO_PRIOR_SPOUSE'),
            callings=item.get('CALLINGS'),
            head_of_house=item.get('HEAD_OF_HOUSE'),
            is_convert=item.get('IS_CONVERT'),
            spouse_name=item.get('SPOUSE_NAME'),
            ordination_date=item.get('ORDINATION_DATE'),
            is_accountable=item.get('IS_ACCOUNTABLE'),
            fullNameSort=item.get('fullNameSort'),
            birth_day=item.get('BIRTH_DAY'),
            move_in_date=item.get('MOVE_IN_DATE'),
            baptismDateSort=item.get('baptismDateSort'),
            is_returned_missionary=item.get('IS_RETURNED_MISSIONARY'),
            household_position=item.get('HOUSEHOLD_POSITION'),
            headOfHouseSort=item.get('headOfHouseSort'),
            preferred_name=item.get('PREFERRED_NAME'),
            address_street_1=item.get('ADDRESS_STREET_1'),
            address_street_2=item.get('ADDRESS_STREET_2'),
            full_name=item.get('FULL_NAME'),
            gender=item.get('GENDER'),
            headOfHouseAndSpouseSort=item.get('headOfHouseAndSpouseSort'),
            mission_country=item.get('MISSION_COUNTRY'),
            age=item.get('AGE'),
            address_country=item.get('ADDRESS_COUNTRY'),
            home_teachers=item.get('HOME_TEACHERS'),
            potential_seminary_student=item.get('POTENTIAL_SEMINARY_STUDENT'),
            has_home_teacher=item.get('HAS_HOME_TEACHER'),
            is_attending_seminary=item.get('IS_ATTENDING_SEMINARY'),
            endowment_date=item.get('ENDOWMENT_DATE'),
            birthDaySort=item.get('birthDaySort'),
            is_attending_institute=item.get('IS_ATTENDING_INSTITUTE'),
            has_children=item.get('HAS_CHILDREN'),
            address_city=item.get('ADDRESS_CITY'),
            baptism_date=item.get('BAPTISM_DATE'),
            birthDateSort=item.get('birthDateSort'),
            marriage_date=item.get('MARRIAGE_DATE'),
            address_state=item.get('ADDRESS_STATE'),
            endowmentDateSort=item.get('endowmentDateSort'),
            priesthood_office=item.get('PRIESTHOOD_OFFICE'),
            spouseNameSort=item.get('spouseNameSort'),
            confirmationDateSort=item.get('confirmationDateSort'),
            preferredNameSort=item.get('preferredNameSort'),
            address_postal_code=item.get('ADDRESS_POSTAL_CODE'),
            marriageDateSort=item.get('marriageDateSort'),
            ordainedDateSort=item.get('ordainedDateSort'),
            inserted_date = inserido_em,
            inserted_by = inserido_por
        )
        # Salvar a instância no banco de dados
        tb_data_users.save()

    #Acessando lcrffe para extrair o numero de membro e o transactionParticipantId
    driver.get('https://lcrffe.churchofjesuschrist.org')
    time.sleep(5)
    driver.get('https://lcrffe.churchofjesuschrist.org/donations?tab=donationSummary')
    time.sleep(5)
    driver.get('https://lcrf.churchofjesuschrist.org/finance/in-unit-participants?orgId=35820&showDonor=true&showPayee=true&showRecipient=true')

    html_content = driver.page_source

    # Usar BeautifulSoup para analisar o HTML e encontrar o JSON
    soup = BeautifulSoup(html_content, 'html.parser')
    pre_tag = soup.find('pre')
    json_text = pre_tag.text
    data = json.loads(json_text)

    for item in data:
        tb_participants = maisferramentas.tb_participants(
            name = item.get('name'),
            age = item.get('age'),
            transactionParticipantId = item.get('transactionParticipantId'),
            membershipId = item.get('membershipId'),
            unitNumber = item.get('unitNumber'),
            member = item.get('member'),
            inserted_date = inserido_em,
            inserted_by = inserido_por
        )
        # Salvar a instância no banco de dados
        tb_participants.save()

    # Fechar o navegador
    driver.quit()

    return JsonResponse({'ok':'ok'})