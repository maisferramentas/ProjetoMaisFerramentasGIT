from django.urls import path, reverse
from .views import def_dados_frequencia, def_frequencia, def_registrar_frequencia, def_cadastrar_novo_usuario

urlpatterns = [
    path('ferramentas/frequencia/dados_frequencia/', def_dados_frequencia, name='def_dados_frequencia'),
    path('ferramentas/frequencia/', def_frequencia, name='def_frequencia'),
    path('ferramentas/registrar_frequencia', def_registrar_frequencia, name='def_registrar_frequencia'),
    path('ferramentas/cadastrar_novo_usuario', def_cadastrar_novo_usuario, name='cadastrar_novo_usuario'),
    path('', def_frequencia, name='pagina_principal'),
]

# Exemplo de uso no código (em uma view, por exemplo):
# url_dados_frequencia = reverse('def_dados_frequencia')
# url_frequencia = reverse('def_frequencia')
# ...
