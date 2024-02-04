from django.urls import path
from django.contrib.auth.decorators import login_required
from .views import def_dados_frequencia,def_frequencia,def_registrar_frequencia,def_cadastrar_novo_usuario,def_login,autenticar,custom_logout,def_deslogar,def_usuario_logado,def_dados_usuario_logado
from django.contrib.auth.views import LogoutView
# from .views import frequencia
# from .views import registrar_frequencia

urlpatterns = [
    path('ferramentas/frequencia/dados_frequencia/', def_dados_frequencia, name='def_dados_frequencia'),

    path('ferramentas/', def_frequencia, name='def_frequencia'),

    path('ferramentas/frequencia/registrar_frequencia', def_registrar_frequencia, name='def_registrar_frequencia'),

    path('ferramentas/frequencia/cadastrar_novo_usuario', def_cadastrar_novo_usuario, name='cadastrar_novo_usuario'),

    path('', def_login, name='pagina_principal'),

    path('ferramentas/login', def_login, name='def_login'),

    path('ferramentas/autenticar/', autenticar, name='autenticar'),

    path('accounts/logout/', custom_logout, name='logout'),

    path('ferramentas/deslogar/', def_deslogar, name='deslogar'),

    path('ferramentas/usuario_logado/', def_usuario_logado, name='deslogar'),

    path('ferramentas/dados_usuario_logado/', def_dados_usuario_logado, name='def_dados_usuario_logado'),

    
]
