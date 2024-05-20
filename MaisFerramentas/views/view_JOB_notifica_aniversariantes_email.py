#Importa funções
from .utils import *

#Importa Model
from MaisFerramentas.models import model_aniversariantes

#Funções
def template_JOB_notifica_aniversariantes_email(request):
    return render(request, 'JOBS/template_JOB_notifica_aniversariantes_email.html')


def EXEC_JOB_notifica_aniversariantes_email(request):
    # Caminho relativo ao diretório base do projeto
    script_path = os.path.join(settings.BASE_DIR, 'puppeteer_script', 'acessa_pagina_de_aniversariantes.js')
    
    # Executa o script usando o caminho relativo
    result = subprocess.run(['node', script_path], capture_output=True, text=True)
    
    return HttpResponse(result.stdout)

#Importa a função de envio de e-mail
from django.core.mail import send_mail
from .views import enviar_email

def enviar_aniversariantes_por_email(request):
    data = request.GET.get('data')
    subject = "Notificação de Aniversariantes"

    # Usar a função para enviar e-mail
    enviar_email(
        recipient_email="allyssonwylliansantosgomes@gmail.com",
        subject=subject,
        message=data,
    )   

    return JsonResponse({'enviar_aniversariantes_por_email':'retorno enviar_aniversariantes_por_email'})