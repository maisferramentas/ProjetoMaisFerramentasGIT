#Importa funções
from .utils import *

def redirect(request):
    url = request.GET.get('url')

    return render(request, 'redirect/redirect.html',{'url': url})
    # return JsonResponse({'url':url})