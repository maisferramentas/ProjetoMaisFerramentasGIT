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


from .views import enviar_email
def enviar_aniversariantes_por_email(request):
    data = request.GET.get('data')

    # Usar a função para enviar e-mail
    enviar_email(
    recipient_email="allyssonwylliansantosgomes@gmail.com",
    subject="Notificação de Aniversariantes",
    message=data,
    )   
    return JsonResponse({'enviar_aniversariantes_por_email':'chegou'})
