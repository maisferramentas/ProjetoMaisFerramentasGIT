from django.urls import path
from .views import def_dados_frequencia,def_frequencia,def_registrar_frequencia,def_cadastrar_novo_usuario,def_login
# from .views import frequencia
# from .views import registrar_frequencia

urlpatterns = [
    path('ferramentas/frequencia/dados_frequencia/', def_dados_frequencia, name='def_dados_frequencia'),

    path('ferramentas/', def_frequencia, name='def_frequencia'),

    path('ferramentas/frequencia/registrar_frequencia', def_registrar_frequencia, name='def_registrar_frequencia'),

    path('ferramentas/frequencia/cadastrar_novo_usuario', def_cadastrar_novo_usuario, name='cadastrar_novo_usuario'),

    path('', def_login, name='pagina_principal'),

    path('ferramentas/login', def_login, name='def_login'),
    
]
