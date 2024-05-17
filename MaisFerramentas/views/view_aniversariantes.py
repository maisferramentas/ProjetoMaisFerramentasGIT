#Importa funções
from .utils import *

#Importa Model
from MaisFerramentas.models import model_aniversariantes

#Funções

def template_aniversariantes(request):
    return render(request, 'aniversariantes/template_aniversariantes.html')

def obter_dados_aniversariantes(request):
    dados_aniversariantes = model_aniversariantes.vw_aniversariantes.objects.all()

    dados_aniversariantes = [model_to_dict(obj) for obj in dados_aniversariantes]

    # data = [model_to_dict(obj) for obj in resultado]

    return JsonResponse({'dados_aniversariantes':dados_aniversariantes})

def template_JOB_notifica_aniversariantes_email(request):
    return render(request, 'JOBS/template_JOB_notifica_aniversariantes_email.html')

from django.core.mail import send_mail
from .views import enviar_email
def enviar_aniversariantes_por_email(request):
    data = request.GET.get('data')
    subject = "Notificação de Aniversariantes"
    subject = timezone.now().strftime('%Y-%m-%d %H:%M:%S.%f')

    # Usar a função para enviar e-mail
    enviar_email(
    recipient_email="allyssonwylliansantosgomes@gmail.com",
    subject=subject,
    message=data,
    )   

    # enviar()
    

    # send_mail(
    #     'Assunto do E-mail',
    #     'Corpo do E-mail',
    #     'maisferramentasmail@gmail.com',
    #     ['allyssonwylliansantosgomes@gmail.com'],
    #     fail_silently=False,
    # )

    return JsonResponse({'enviar_aniversariantes_por_email':'chegou'})

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
def enviar():
    
    # Configurar as informações do servidor SMTP do Outlook
    smtp_host = 'smtp.office365.com'
    smtp_port = 587  # Porta TLS
    email_address = 'maisferramentas1@outlook.com'
    email_password = '6Bdckjk8l53f4*'

    # Configurar o e-mail
    msg = MIMEMultipart()
    msg['From'] = email_address
    msg['To'] = 'allyssonwylliansantosgomes@gmail.com'
    msg['Subject'] = 'Outlook teste'

    # Adicionar corpo da mensagem
    body = 'Conteúdo do e-mail.'
    msg.attach(MIMEText(body, 'plain'))

    # Iniciar conexão com o servidor SMTP
    server = smtplib.SMTP(smtp_host, smtp_port)
    server.starttls()  # Iniciar conexão segura
    server.login(email_address, email_password)  # Fazer login no servidor SMTP

    # Enviar e-mail
    text = msg.as_string()
    server.sendmail(email_address, 'allyssonwylliansantosgomes@gmail.com', text)

    # Encerrar conexão com o servidor SMTP
    server.quit()
