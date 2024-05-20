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

    return JsonResponse({'dados_aniversariantes':dados_aniversariantes})

