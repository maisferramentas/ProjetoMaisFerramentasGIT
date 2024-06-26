from __future__ import print_function
from django.core.serializers import serialize
from django.http import JsonResponse
# #from .models import Frequencia
from django.shortcuts import render, redirect
from django.forms.models import model_to_dict
from django.db.models import Q 
from datetime import date
from django.utils import timezone
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import never_cache
from django.http import HttpResponse
from django.template.loader import render_to_string 
import json
# from .utils import *

from MaisFerramentas.models import models
@login_required
def def_dados_frequencia(request):
    data_frequencia = request.GET.get('data_frequencia')
    id_tipo_frequencia = request.GET.get('id_tipo_frequencia')
    
    resultado = models.model_dados_frequencia.objects.obter_dados_frequencia_query(data_frequencia, id_tipo_frequencia)
    
    data = [model_to_dict(obj) for obj in resultado]
    
    return JsonResponse({"data": data}, safe=False)

from django.http import FileResponse, Http404
from django.conf import settings
import os

def def_get_file(request):
    path = request.GET.get('path')
    return FileResponse(open(path, 'rb'))

@never_cache
def def_login(request):
    return render(request, 'login.html')

@login_required
def def_frequencia(request):
    return render(request, 'frequencia.html')

@login_required
def def_atas_template(request):
    return render(request, 'ata_reuniao.html')

@login_required
def def_Ferramentas_template(request):
    return render(request, 'Ferramentas.html')

#from .models import models.model_registrar_frequencia
def def_registrar_frequencia(request):
    data_frequencia = request.GET.get('data_frequencia')
    id_tipo_frequencia = request.GET.get('id_tipo_frequencia')
    id_membro_interno = request.GET.get('id_membro_interno')
    status_frequencia = request.GET.get('status_frequencia')
    inserido_em = request.GET.get('inserido_em')
    inserido_por = models.model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('id_membro_interno', flat=True).first()


    registrar_frequencia = models.model_registrar_frequencia(
        data_frequencia = data_frequencia,
        id_tipo_frequencia = id_tipo_frequencia,  
        id_membro_interno = id_membro_interno,  
        status_frequencia = status_frequencia,  
        inserido_em = timezone.now().strftime('%Y-%m-%d %H:%M:%S.%f'),
        inserido_por = inserido_por
    )

    registrar_frequencia.save()

    return JsonResponse({"retorno": "Frequência Registrada."}, safe=False)

@login_required
def def_cadastrar_novo_usuario(request):
    nome_interno = request.GET.get('nome_interno')
    sexo = request.GET.get('sexo')
    ano_do_nascimento = request.GET.get('ano_do_nascimento')
    id_perfil = request.GET.get('id_perfil')
    inserido_por = models.model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('id_membro_interno', flat=True).first()
    
    cadastrar_novo_usuario = models.model_cadastrar_novo_usuario(
        nome_interno = nome_interno,
        sexo = sexo,
        ano_do_nascimento = ano_do_nascimento,
        id_perfil = id_perfil,
        status_usuario = 1,
        inserido_por = inserido_por,
        inserido_em = timezone.now().strftime('%Y-%m-%d %H:%M:%S.%f'),
    )

    cadastrar_novo_usuario.save()

    id_membro_interno = cadastrar_novo_usuario.versao_id_membro_interno

    print(id_membro_interno)


    # Filtra os objetos onde id_membro_interno é nulo
    objetos_para_atualizar = models.model_cadastrar_novo_usuario.objects.filter(id_membro_interno__isnull=True)

    # Itera sobre os objetos encontrados
    for objeto_para_atualizar in objetos_para_atualizar:
        # Atualiza o campo id_membro_interno para ser igual ao valor de versao_id_membro_interno
        objeto_para_atualizar.id_membro_interno = objeto_para_atualizar.versao_id_membro_interno

        # Salva a atualização no banco de dados
        objeto_para_atualizar.save()

    return JsonResponse({'id_membro_interno': id_membro_interno})

from django.contrib.auth import authenticate, login
from django.http import JsonResponse

def autenticar(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')

        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            return JsonResponse({'status': 'success', 'redirect': '/ferramentas/'})
        else:
            return JsonResponse({'status': 'error', 'message': 'Credenciais inválidas'})

    return JsonResponse({'status': 'error', 'message': 'Método não permitido'})

from django.contrib.auth import logout
from django.shortcuts import redirect

def custom_logout(request):
    logout(request)
    return redirect('/ferramentas/login')  # Redireciona para a página de login após o logout

def def_deslogar(request):
    logout(request)

    return redirect('/ferramentas/login')  # Redireciona para a página de login após o logout

from django.http import JsonResponse

def def_usuario_logado(request):
    if request.user.is_authenticated:
        usuario_logado = request.user.username
        return usuario_logado
    else:
        return JsonResponse({'usuario_logado': None})

def user_logged(request):
    user_logged = models.model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('id_membro_interno', flat=True).first()

    return user_logged
import pytz
def timestamp():
    # Obtém o tempo atual em UTC
    now_utc = timezone.now()
    # Converte para o fuso horário desejado (por exemplo, 'America/Sao_Paulo')
    timezone_sao_paulo = pytz.timezone('America/Sao_Paulo')
    now_sao_paulo = now_utc.astimezone(timezone_sao_paulo)
    # Formata a data e hora ajustadas
    timestamp = now_sao_paulo.strftime('%Y-%m-%d %H:%M:%S.%f')
    return timestamp
    

def def_dados_usuario_logado(request):
    id_membro_interno = models.model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('id_membro_interno', flat=True).first()

    nome_usuario_login = models.model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('nome_usuario_login', flat=True).first()

    dados_adicionais = models.vw_usuarios.objects.filter(id_membro_interno = id_membro_interno)

    dados_adicionais = [model_to_dict(obj) for obj in dados_adicionais]

    return JsonResponse({'id_membro_interno': id_membro_interno, 'nome_usuario_logado':nome_usuario_login, 'dados_adicionais':dados_adicionais})

def def_mapa(request):
    return render(request, 'mapa.html')


# Python SDK: https://github.com/sendinblue/APIv3-python-library


def def_teste(request):
    return render(request, 'mapa.html')


#from .models import models.model_capturaLocalizacao
def def_salvar_localizacao(request):
    navegador = request.GET.get('navegador') 
    geolocation = request.GET.get('geolocation') 
    ip = request.GET.get('ip') 
    local_ip = request.GET.get('local_ip') 
    data = request.GET.get('data') 
    texto = request.GET.get('texto') 

    
    cadastrar_novo_acesso = models.model_capturaLocalizacao(
        # data = data,
        ip = ip,
        local_ip = local_ip,
        navegador = navegador,
        inserido_em = timezone.now().strftime('%Y-%m-%d %H:%M:%S.%f'),
    )

    cadastrar_novo_acesso.save()

    id_registro_localizacao = cadastrar_novo_acesso.versao_id_registro_localizacao

    # Filtra os objetos onde id_membro_interno é nulo
    objetos_para_atualizar = models.model_capturaLocalizacao.objects.filter(versao_id_registro_localizacao=id_registro_localizacao)

    # Itera sobre os objetos encontrados
    for objeto_para_atualizar in objetos_para_atualizar:
        # Atualiza o campo id_membro_interno para ser igual ao valor de versao_id_membro_interno
        objeto_para_atualizar.id_registro_localizacao = id_registro_localizacao

        # Salva a atualização no banco de dados
        objeto_para_atualizar.save()

    # Usar a função para enviar e-mail
    # enviar_email(
    # recipient_email="allyssonwylliansantosgomes@gmail.com",
    # subject="Novo Acesso Registrado",
    # message=texto,
    # )   

    return JsonResponse({'id_registro_localizacao': id_registro_localizacao})

import requests

def def_atualiza_localizacao(request):
    navegador = request.GET.get('navegador') 
    geolocation = request.GET.get('geolocation') 
    ip = request.GET.get('ip') 
    local_ip = request.GET.get('local_ip') 
    data = request.GET.get('data') 
    texto = request.GET.get('texto') 
    id_registro_localizacao = request.GET.get('id_registro_localizacao') 

    
    atualzar_acesso = models.model_capturaLocalizacao(
        id_registro_localizacao = id_registro_localizacao,
        # id_membro_interno = null,
        # data = data,
        ip = ip,
        local_ip = local_ip,
        navegador = navegador,
        geolocation = geolocation,
        inserido_em = timezone.now().strftime('%Y-%m-%d %H:%M:%S.%f'),
        )

    atualzar_acesso.save()

    # Usar a função para enviar e-mail
    enviar_email(
    recipient_email="allyssonwylliansantosgomes@gmail.com",
    subject="Novo Acesso Registrado",
    message=texto,
    )   

    return JsonResponse({'id_registro_localizacao': id_registro_localizacao})


def testemail(request):
    enviar_email(
    recipient_email="allyssonwylliansantosgomes@gmail.com",
    subject="Novo Acesso Registrado",
    message='teste',
    ) 

    return JsonResponse({'testemail': 'testemail'})

import json
#from .models import model_ata_no_banco
def enviar_ata_para_o_banco(request):
    data = request.POST.get('data')

    inserido_por = models.model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('id_membro_interno', flat=True).first()
    
    inserido_em=timezone.now()
    dados = json.loads(data)
    for item in dados:
        ata = models.model_ata_no_banco(
            id_ata=item.get('id_ata'),
            data_da_ata=item.get('data_da_ata'),
            tipo_de_ata=item.get('tipo_de_ata'),
            card=item.get('card'),
            elemento_oculto=item.get('elemento_oculto'),
            label=item.get('label'),
            tipo=item.get('tipo'),
            value=item.get('value'),
            inserido_por=inserido_por,
            inserido_em=inserido_em
        )
        # Salvar a instância no banco de dados
        ata.save()

    return JsonResponse({'result': 'Retorno do server para enviar_ata_para_o_banco'})

from django.core import serializers
def obter_dados_de_ata_no_banco(request):
    data_da_ata = request.GET.get('data_da_ata')
    tipo_de_ata = request.GET.get('tipo_de_ata')
    id_ata = request.GET.get('id_ata')
    
    #Busca a versão mais recente da ata
    versao_mais_recente_da_ata = models.model_ata_no_banco.objects.filter(id_ata=id_ata).order_by('-inserido_em').first()

    if versao_mais_recente_da_ata is not None:
        inserido_em = versao_mais_recente_da_ata.inserido_em
        # Busca os dados da ata de acordo com o id e o momento em que foi inserida
        dados_de_ata_no_banco = models.model_ata_no_banco.objects.filter(id_ata=id_ata, inserido_em=inserido_em)

        data = [model_to_dict(obj) for obj in dados_de_ata_no_banco]
    else:
        data = []

    return JsonResponse({"data": data}, safe=False)


def obter_id_ata(request):
    data_da_ata_para_obter_ID = request.GET.get('data_da_ata_para_obter_ID')
    tipo_de_ata_para_obter_ID = request.GET.get('tipo_de_ata_para_obter_ID')

    #Busca o id da ata de acordo com a data
    consulta_id_ata = models.model_ata_no_banco.objects.raw('SELECT versao_id_ata, id_ata FROM atas.tb_atas WHERE data_da_ata = %s AND tipo_de_ata = %s ORDER BY id_ata DESC LIMIT 1;', [data_da_ata_para_obter_ID, tipo_de_ata_para_obter_ID])

    print(consulta_id_ata)
    
    #Caso encontre um id retorna o id_ata, se não o configura nulo e passa para o p´roximo passo
    if consulta_id_ata: 
        id_ata = consulta_id_ata[0].id_ata
    else:
        id_ata = None

    #Se Não há ata para esta data cria-se um novo id = max id + 1
    if id_ata is None:
        consulta_id_ata = models.model_ata_no_banco.objects.raw('SELECT versao_id_ata,COALESCE(id_ata,1)+1 id_ata FROM atas.tb_atas ORDER BY id_ata DESC LIMIT 1;')

    #Se há um id retorna id_ata, se não retorna 1 (primeiro id da tabela)
    if consulta_id_ata: 
        id_ata = consulta_id_ata[0].id_ata
    else:
        id_ata = 1
    
    return JsonResponse({'id_ata': id_ata})

def obter_informacoes_de_apoio(request):
    chamados = models.tb_chamados.objects.all()
    chamados = [model_to_dict(obj) for obj in chamados]

    hinos = models.tb_hinos.objects.all()
    hinos = [model_to_dict(obj) for obj in hinos]

    nomes = models.vw_usuarios.objects.all()
    nomes = [model_to_dict(obj) for obj in nomes]

    atas_padrao = models.tb_atas_padrao.objects.all()
    atas_padrao = [model_to_dict(obj) for obj in atas_padrao]

    cards_padrao = models.tb_cards_padrao.objects.all()
    cards_padrao = [model_to_dict(obj) for obj in cards_padrao]

    return JsonResponse({'chamados': chamados,'hinos':hinos,'nomes':nomes, 'atas_padrao':atas_padrao, 'cards_padrao':cards_padrao})


# Credenciais SMTP
# Nome de usuário do IAM
# ses-smtp-user.20240516-173633
# Nome de usuário SMTP
# AKIAXYKJU4FBYJI6UAUG
# Senha SMTP
# BEgUP32F13quTuUNfO+4DPwPJJDdg3SOELUT8cp1yMJM
# endpoint SMTP email-smtp.sa-east-1.amazonaws.com


import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
def enviar_email(recipient_email, subject, message):
    # smtp_host="smtp-relay.brevo.com"
    # sender_email="maisferramentasmail@gmail.com"
    # senha_email="OB3R6tgNS2XY7DWI"
    # smtp_port=587
    
    # # Configurar o e-mail
    # email = MIMEMultipart()
    # email['From'] = sender_email
    # email['To'] = recipient_email
    # email['Subject'] = subject

    # # Adicionar corpo da mensagem
    # email.attach(MIMEText(message, 'plain'))

    # # Configurar servidor SMTP
    # server = smtplib.SMTP(smtp_host, smtp_port)
    # server.starttls()  # Iniciar conexão segura
    # server.login(sender_email, senha_email)  # Faça login no servidor SMTP

    # # Enviar e-mail
    # text = email.as_string()
    # server.sendmail(sender_email, recipient_email, text)

    # # Encerrar conexão com o servidor SMTP
    # server.quit()

    
    # Configurar as informações do servidor SMTP do Outlook
    smtp_host = 'smtp.office365.com'
    smtp_port = 587  # Porta TLS
    email_address = 'maisferramentas1@outlook.com'
    email_password = '6Bdckjk8l53f4*'

    # Configurar o e-mail
    msg = MIMEMultipart()
    msg['From'] = email_address
    msg['To'] = recipient_email
    msg['Subject'] = subject

    # Adicionar corpo da mensagem
    msg.attach(MIMEText(message, 'html'))

    # Iniciar conexão com o servidor SMTP
    server = smtplib.SMTP(smtp_host, smtp_port)
    server.starttls()  # Iniciar conexão segura
    server.login(email_address, email_password)  # Fazer login no servidor SMTP

    # Enviar e-mail
    text = msg.as_string()
    server.sendmail(email_address, recipient_email, text)

    # Encerrar conexão com o servidor SMTP
    server.quit()


def obter_modelo_de_ata_padrao(request):
    return render(request, 'modelos_de_ata.html')
    # return JsonResponse({'return':'return'})


def template_email_padrao(request):
    return render(request, 'Email/template_email_padrao.html')

# from .models import frequencia_vw_frequencia
def historico_de_frequencia_do_membro(request):
    data = request.GET.get('data')
    data = json.loads(data)

    id_membro_interno = data['id_membro_interno']
    data_fim = data['data_fim']
    data_inicio = data['data_inicio']

    historico_de_frequencia_do_membro = models.frequencia_vw_frequencia.objects.filter(id_membro_interno=id_membro_interno,data_frequencia__range=[data_inicio, data_fim],status_frequencia=1)
    historico_de_frequencia_do_membro = [model_to_dict(obj) for obj in historico_de_frequencia_do_membro]

    return JsonResponse({"historico_de_frequencia_do_membro":historico_de_frequencia_do_membro})

