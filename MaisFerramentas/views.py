from django.core.serializers import serialize
from django.http import JsonResponse
# from .models import Frequencia
from django.shortcuts import render, redirect
from django.forms.models import model_to_dict
from django.db.models import Q 
from datetime import date
from django.utils import timezone
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import never_cache


# def dados_frequencia(request):
#     dados_frequencia = Frequencia.objects.all()
#     data = [model_to_dict(obj) for obj in dados_frequencia]
#     # print(dados_frequencia)
#     return JsonResponse({"data": data}, safe=False)

from .models import model_dados_frequencia
@login_required
def def_dados_frequencia(request):
    data_frequencia = request.GET.get('data_frequencia')
    id_tipo_frequencia = request.GET.get('id_tipo_frequencia')

    resultado = model_dados_frequencia.objects.obter_dados_frequencia_query(data_frequencia, id_tipo_frequencia)
    
    data = [model_to_dict(obj) for obj in resultado]

    return JsonResponse({"data": data}, safe=False)

@never_cache
def def_login(request):
    return render(request, 'login.html')
    # return redirect('/login.html/')

@login_required
def def_frequencia(request):
    return render(request, 'frequencia.html')

from .models import model_registrar_frequencia
def def_registrar_frequencia(request):
    data_frequencia = request.GET.get('data_frequencia')
    id_tipo_frequencia = request.GET.get('id_tipo_frequencia')
    id_membro_interno = request.GET.get('id_membro_interno')
    status_frequencia = request.GET.get('status_frequencia')
    inserido_em = request.GET.get('inserido_em')
    # inserido_por = request.GET.get('inserido_por')
    inserido_por = model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('id_membro_interno', flat=True).first()


    registrar_frequencia = model_registrar_frequencia(
        data_frequencia = data_frequencia,
        id_tipo_frequencia = id_tipo_frequencia,  
        id_membro_interno = id_membro_interno,  
        status_frequencia = status_frequencia,  
        inserido_em = timezone.now().strftime('%Y-%m-%d %H:%M:%S.%f'),
        inserido_por = inserido_por
    )

    registrar_frequencia.save()

    return JsonResponse({"retorno": "Frequência Registrada."}, safe=False)

from .models import model_cadastrar_novo_usuario
@login_required
def def_cadastrar_novo_usuario(request):
    nome_interno = request.GET.get('nome_interno')
    sexo = request.GET.get('sexo')
    ano_do_nascimento = request.GET.get('ano_do_nascimento')
    id_perfil = request.GET.get('id_perfil')
    # inserido_por = request.GET.get('inserido_por')
    inserido_por = model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('id_membro_interno', flat=True).first()
    
    cadastrar_novo_usuario = model_cadastrar_novo_usuario(
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
    objetos_para_atualizar = model_cadastrar_novo_usuario.objects.filter(id_membro_interno__isnull=True)

    # Itera sobre os objetos encontrados
    for objeto_para_atualizar in objetos_para_atualizar:
        # Atualiza o campo id_membro_interno para ser igual ao valor de versao_id_membro_interno
        objeto_para_atualizar.id_membro_interno = objeto_para_atualizar.versao_id_membro_interno

        # Salva a atualização no banco de dados
        objeto_para_atualizar.save()

    # return JsonResponse({"retorno": "Cadastro Registrado."}, safe=False)
    return JsonResponse({'id_membro_interno': id_membro_interno})

from django.contrib.auth import authenticate, login
from django.http import JsonResponse

from .models import model_tb_acesso
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

def def_dados_usuario_logado(request):
    id_membro_interno = model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('id_membro_interno', flat=True).first()
    nome_usuario_login = model_tb_acesso.objects.filter(nome_usuario_login=def_usuario_logado(request)).values_list('nome_usuario_login', flat=True).first()

    return JsonResponse({'id_membro_interno': id_membro_interno, 'nome_usuario_logado':nome_usuario_login})