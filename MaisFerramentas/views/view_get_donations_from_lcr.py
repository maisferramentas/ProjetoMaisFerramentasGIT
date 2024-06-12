
from .utils import *
from MaisFerramentas.models import models
from .views import def_usuario_logado
from .view_access_lcr import access_lcr
from bs4 import BeautifulSoup

def get_donations_from_lcr(request):
    
    driver = access_lcr()
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
    # Fechar o navegador
    print(data)
    driver.quit()

    return JsonResponse({'ok':'result'})