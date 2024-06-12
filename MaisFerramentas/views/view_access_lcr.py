import time
import json
import requests
import os
import json
from django.http import JsonResponse
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.chrome.options import Options
from .utils import *
# pip install selenium
# pip install webdriver-manager
# pip install BeautifulSoup
# pip install bs4

# No Ubuntu
# pip install selenium
# pip install webdriver-manager
# sudo apt-get install -y chromium-chromedriver
# sudo apt-get install -y chromium-browser


# Configurar opções do Chromium
options = webdriver.ChromeOptions()
options.add_argument("--headless")  
options.add_argument("--disable-gpu") 
options.add_argument("--no-sandbox") 
options.add_argument("--disable-dev-shm-usage")

def access_lcr():
    # url = request
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
    print('login realizado com sucesso')
    
    print('acessando link solicitado')
    # Acessa o Relatório
    time.sleep(2) # Pausa para o redirecionamento
    
    return driver

# update_tb_user('nada')