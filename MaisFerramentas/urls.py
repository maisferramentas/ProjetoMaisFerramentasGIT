from django.urls import path
from django.contrib.auth.decorators import login_required
from .views import def_dados_frequencia,def_frequencia,def_registrar_frequencia,def_cadastrar_novo_usuario,def_login,autenticar,custom_logout,def_deslogar,def_usuario_logado,def_dados_usuario_logado,def_atas_template,def_Ferramentas_template,def_mapa,def_salvar_localizacao, def_teste,def_atualiza_localizacao,enviar_ata_para_o_banco,obter_dados_de_ata_no_banco,obter_id_ata,obter_informacoes_de_apoio
from django.contrib.auth.views import LogoutView
# from .views import frequencia
# from .views import registrar_frequencia

urlpatterns = [
    path('ferramentas/', def_Ferramentas_template, name='def_Ferramentas_template'),

    path('ferramentas/frequencia', def_frequencia, name='def_frequencia'),
    
    path('ferramentas/frequencia/dados_frequencia/', def_dados_frequencia, name='def_dados_frequencia'),

    path('ferramentas/frequencia/registrar_frequencia', def_registrar_frequencia, name='def_registrar_frequencia'),

    path('ferramentas/frequencia/cadastrar_novo_usuario', def_cadastrar_novo_usuario, name='cadastrar_novo_usuario'),

    path('', def_login, name='pagina_principal'),

    path('ferramentas/login', def_login, name='def_login'),

    path('ferramentas/autenticar/', autenticar, name='autenticar'),

    path('accounts/logout/', custom_logout, name='logout'),

    path('ferramentas/deslogar/', def_deslogar, name='deslogar'),

    path('ferramentas/usuario_logado/', def_usuario_logado, name='deslogar'),

    path('ferramentas/dados_usuario_logado/', def_dados_usuario_logado, name='def_dados_usuario_logado'),

    path('ferramentas/atas/', def_atas_template, name='def_atas_template'),

    path('ferramentas/mapa/', def_mapa, name='def_mapa'),

    path('ferramentas/salvar_localizacao/', def_salvar_localizacao, name='salvar_localizacao'),

    path('ferramentas/def_atualiza_localizacao/', def_atualiza_localizacao, name='def_atualiza_localizacao'),
        
    path('teste/', def_teste, name='teste'),
    
    path('enviar_ata_para_o_banco', enviar_ata_para_o_banco, name='/enviar_ata_para_o_banco'),

    path('obter_dados_de_ata_no_banco', obter_dados_de_ata_no_banco, name='/obter_dados_de_ata_no_banco'),

    path('obter_id_ata', obter_id_ata, name='/obter_id_ata'),

    
    path('obter_informacoes_de_apoio', obter_informacoes_de_apoio, name='/obter_informacoes_de_apoio')
    

]
