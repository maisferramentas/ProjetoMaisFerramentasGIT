import schedule
import time
import requests
import datetime

def perform_get_requests():
    urls = [
        'http://18.231.47.174/EXEC_JOB_notifica_aniversariantes_email',
        'http://18.231.47.174/get_data_from_lds'
    ]

    results = []

    for url in urls:
        try:
            response = requests.get(url)
            if response.status_code == 200:
                results.append(response.json())
                print(f"Requisição para {url} foi bem-sucedida.")
            else:
                print(f"Falha na requisição para {url}: {response.status_code}")
        except Exception as e:
            print(f"Erro ao fazer a requisição para {url}: {e}")

# Agendar a tarefa para ser executada diariamente às 5 da manhã
schedule.every().day.at("06:00").do(perform_get_requests)

# Loop contínuo para verificar o agendamento
while True:
    schedule.run_pending()
    time.sleep(1)  # Aguarda 1 segundo entre as verificações



# Criar um serviço (JOB) no Ubuntu:
# Description=Executa Job Link
# After=network.target

# [Service]
# User=ubuntu
# Group=ubuntu
# WorkingDirectory=/home/ubuntu/projetos/projetomaisferramentas/ProjetoMaisFerramentas
# ExecStart=/usr/bin/python3 /home/ubuntu/projetos/projetomaisferramentas/ProjetoMaisFerramentas/MaisFerramentas/views/jo>Restart=always
# RestartSec=10s

# [Install]
# WantedBy=multi-user.target

# --Executar os comandos de inicialização
# sudo systemctl daemon-reload
# sudo systemctl restart meu_projeto_job_link
# sudo systemctl status meu_projeto_job_link

