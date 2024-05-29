from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
import time
import json
import requests
import os
# pip install selenium
# pip install webdriver-manager
# pip install BeautifulSoup

# Configurar opções do Chromium
options = webdriver.ChromeOptions()
options.add_argument("--headless")  
options.add_argument("--disable-gpu") 
options.add_argument("--no-sandbox") 
options.add_argument("--disable-dev-shm-usage")

try:
    print('iniciando navegador')
    if os.name == 'posix':
        executable_path = '/usr/bin/chromium-browser'
        chromedriver_path = '/usr/bin/chromedriver'
        options.binary_location = executable_path
        service = ChromeService(executable_path=chromedriver_path)
        driver = webdriver.Chrome(service=service, options=options)
    else:
        driver = webdriver.Chrome(options=options)

    # Navegar para a página
    driver.get('https://lcr.churchofjesuschrist.org/?lang=por')

    print('realizando login')
    # Esperar a página carregar e o campo de usuário estar presente
    WebDriverWait(driver, 20).until(EC.presence_of_element_located((By.CSS_SELECTOR, 'input[type="text"]')))

    # Inserir o usuário
    username = driver.find_element(By.CSS_SELECTOR, 'input[type="text"]')
    username.send_keys('allyssonwyllian')

    # Acionar o botão de submit
    submit_button = driver.find_element(By.CSS_SELECTOR, 'input[type="submit"]')
    submit_button.click()

    # Esperar a página carregar e o campo de senha estar presente
    WebDriverWait(driver, 20).until(EC.presence_of_element_located((By.CSS_SELECTOR, 'input[type="password"]')))

    # Inserir a senha
    password = driver.find_element(By.CSS_SELECTOR, 'input[type="password"]')
    password.send_keys('6bdckjk8l53f40')

    # Acionar o botão de submit
    submit_button = driver.find_element(By.CSS_SELECTOR, 'input[type="submit"]')
    submit_button.click()

    # Esperar o login ser concluído
    WebDriverWait(driver, 20).until(EC.url_contains('lcr.churchofjesuschrist.org'))
    print('login finalizado com sucesso')
    
    print('acessando relatório')
    # Acessa o Relatório
    time.sleep(2) # Pausa para o redirecionamento
    driver.get('https://lcr.churchofjesuschrist.org/api/report/custom-reports/run-report/45c90fc8-f097-4fa9-9ea6-151956b0d5af?lang=eng')

    time.sleep(2)
    
    # Extrair o HTML da página
    html_content = driver.page_source

    # Usar BeautifulSoup para analisar o HTML e encontrar o JSON
    soup = BeautifulSoup(html_content, 'html.parser')
    pre_tag = soup.find('pre')
    if pre_tag:
        json_text = pre_tag.text
        data = json.loads(json_text)
        
        # Acessar o objeto membros dentro do JSON
        membros = data.get("members", [])
        
        # Enviar os membros para a rota externa
        response = requests.post('http://18.231.47.174/relatorio?relatorio=members', json=membros)
        if response.status_code == 200:
            print('Dados enviados com sucesso.')
        else:
            print(f'Erro ao enviar dados: {response.status_code}')
    else:
        print("Erro: tag <pre> não encontrada.")

    print('relatório extraído com sucesso')
finally:
    # Fechar o navegador
    driver.quit()
    print("finalizando processo.")
