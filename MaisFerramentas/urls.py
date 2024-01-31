from django.urls import path
from .views import def_dados_frequencia,def_frequencia,def_registrar_frequencia,def_cadastrar_novo_usuario
# from .views import frequencia
# from .views import registrar_frequencia

urlpatterns = [
    path('ferramentas/frequencia/dados_frequencia/', def_dados_frequencia, name='def_dados_frequencia'),

    path('ferramentas/frequencia/', def_frequencia, name='def_frequencia'),

    path('ferramentas/registrar_frequencia', def_registrar_frequencia, name='def_registrar_frequencia'),

    path('ferramentas/cadastrar_novo_usuario', def_cadastrar_novo_usuario, name='cadastrar_novo_usuario'),

    path('', def_frequencia, name='pagina_principal'),

    path('https://maisferramentas-98f68a386705.herokuapp.com/dados_frequencia/', def_dados_frequencia, name='def_dados_frequencia'),
    
]
