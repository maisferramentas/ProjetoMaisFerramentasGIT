from django.urls import path
from django.contrib.auth.decorators import login_required
from MaisFerramentas.views import views,view_aniversariantes,view_redirect,view_JOB_notifica_aniversariantes_email
from django.contrib.auth.views import LogoutView

urlpatterns = [
    path('ferramentas/', views.def_Ferramentas_template, name='def_Ferramentas_template'),

    path('ferramentas/frequencia', views.def_frequencia, name='def_frequencia'),
    
    path('ferramentas/frequencia/dados_frequencia/', views.def_dados_frequencia, name='def_dados_frequencia'),

    path('ferramentas/frequencia/registrar_frequencia', views.def_registrar_frequencia, name='def_registrar_frequencia'),

    path('ferramentas/frequencia/cadastrar_novo_usuario', views.def_cadastrar_novo_usuario, name='cadastrar_novo_usuario'),

    path('', views.def_login, name='pagina_principal'),

    path('ferramentas/login', views.def_login, name='def_login'),

    path('ferramentas/autenticar/', views.autenticar, name='autenticar'),

    path('accounts/logout/', views.custom_logout, name='logout'),

    path('ferramentas/deslogar/', views.def_deslogar, name='deslogar'),

    path('ferramentas/usuario_logado/', views.def_usuario_logado, name='deslogar'),

    path('ferramentas/dados_usuario_logado/', views.def_dados_usuario_logado, name='def_dados_usuario_logado'),

    path('ferramentas/atas/', views.def_atas_template, name='def_atas_template'),

    path('ferramentas/mapa/', views.def_mapa, name='def_mapa'),

    path('ferramentas/salvar_localizacao/', views.def_salvar_localizacao, name='salvar_localizacao'),

    path('ferramentas/def_atualiza_localizacao/', views.def_atualiza_localizacao, name='def_atualiza_localizacao'),
        
    path('teste/', views.def_teste, name='teste'),
    
    path('enviar_ata_para_o_banco', views.enviar_ata_para_o_banco, name='/enviar_ata_para_o_banco'),

    path('obter_dados_de_ata_no_banco', views.obter_dados_de_ata_no_banco, name='/obter_dados_de_ata_no_banco'),

    path('obter_id_ata', views.obter_id_ata, name='/obter_id_ata'),

    
    path('obter_informacoes_de_apoio', views.obter_informacoes_de_apoio, name='/obter_informacoes_de_apoio'),

    path('obter_modelo_de_ata_padrao', views.obter_modelo_de_ata_padrao, name='/obter_modelo_de_ata_padrao'),
    
    path('template_aniversariantes', view_aniversariantes.template_aniversariantes, name='/template_aniversariantes'),

    path('obter_dados_aniversariantes', view_aniversariantes.obter_dados_aniversariantes, name='/obter_dados_aniversariantes'),

    path('enviar_aniversariantes_por_email', view_JOB_notifica_aniversariantes_email.enviar_aniversariantes_por_email, name='/enviar_aniversariantes_por_email'),

    path('template_JOB_notifica_aniversariantes_email', view_JOB_notifica_aniversariantes_email.template_JOB_notifica_aniversariantes_email, name='/template_JOB_notifica_aniversariantes_email'),

    path('redirect', view_redirect.redirect, name='/redirect'),

    path('testemail', views.testemail, name='/testemail'),

    path('EXEC_JOB_notifica_aniversariantes_email', view_JOB_notifica_aniversariantes_email.EXEC_JOB_notifica_aniversariantes_email, name='/EXEC_JOB_notifica_aniversariantes_email'),
    
    path('template_email_padrao', views.template_email_padrao, name='/template_email_padrao'),
    
    

]
