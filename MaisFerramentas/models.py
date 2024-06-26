from django.db import models
from django.db.models import F, Func, Value, CharField, IntegerField, DateField
from django.db.models.functions import Cast
from datetime import date
from django.db import models, connection

class model_function_obter_dados_frequencia(models.Manager):
    def obter_dados_frequencia_query(self, param1, param2):
        
        query = "SELECT * FROM frequencia.obter_dados_frequencia(%s, %s);"

        with connection.cursor() as cursor:
            cursor.execute(query, [param1, param2])
            # Usar fetchall() para obter todas as linhas
            result = cursor.fetchall()

        # Mapear os resultados para instâncias do modelo
        fields = [field.name for field in self.model._meta.fields]
        instances = [self.model(**dict(zip(fields, row))) for row in result]

        return instances

class model_dados_frequencia(models.Model):
    data_frequencia = models.DateField()
    id_membro_interno = models.IntegerField(primary_key=True)
    nome_interno = models.CharField(max_length=255)
    sexo = models.CharField(max_length=255)
    id_perfil = models.IntegerField()
    ativo = models.IntegerField()
    idade = models.IntegerField()
    organizacao = models.CharField()
    ministradores = models.CharField()
    id_tipo_frequencia = models.IntegerField()
    tipo_frequencia = models.CharField(max_length=255)
    status_frequencia = models.IntegerField()
    inserido_em = models.DateTimeField()
    inserido_por = models.IntegerField()
    inserido_por_nome = models.CharField(max_length=255)
    
    objects = model_function_obter_dados_frequencia()

class model_registrar_frequencia(models.Model):
    id_frequencia = models.AutoField(primary_key=True)
    data_frequencia = models.DateTimeField()
    id_tipo_frequencia = models.IntegerField()
    id_membro_interno = models.IntegerField()
    status_frequencia = models.IntegerField()
    inserido_em = models.DateTimeField()
    inserido_por = models.IntegerField()
        
    class Meta:
        db_table = '"frequencia"."tb_frequencia"'
        managed = False

class model_cadastrar_novo_usuario(models.Model):
    versao_id_membro_interno = models.AutoField(primary_key=True)
    id_membro_interno = models.IntegerField()
    nome_interno = models.CharField(max_length=255)
    sexo = models.CharField(max_length=255)
    ano_do_nascimento = models.IntegerField()
    id_perfil = models.IntegerField()
    status_usuario = models.IntegerField()
    inserido_por = models.IntegerField()
    inserido_em = models.DateTimeField()

    class Meta: 
        db_table = '"maisferramentas"."tb_usuarios"'

class model_tb_acesso(models.Model):
    versao_id_acesso  = models.AutoField(primary_key=True)
    id_acesso = models.IntegerField()
    id_membro_interno  = models.IntegerField()
    nome_usuario_login = models.CharField(max_length=255)
    id_tipo_acesso = models.IntegerField()

    class Meta: 
        db_table = '"maisferramentas"."tb_acessos"'

class model_capturaLocalizacao(models.Model):
    versao_id_registro_localizacao = models.AutoField(primary_key=True)
    id_registro_localizacao = models.IntegerField()
    id_membro_interno = models.IntegerField()
    data = models.DateTimeField()
    ip = models.CharField(max_length=255)
    local_ip = models.CharField(max_length=255)
    navegador = models.CharField(max_length=255)
    geolocation = models.CharField(max_length=255)
    inserido_em = models.DateTimeField()

    class Meta:
        db_table = '"mapa"."tb_captura_localizacao"'

class model_ata_no_banco(models.Model):
    versao_id_ata = models.AutoField(primary_key=True)
    id_ata = models.IntegerField()
    data_da_ata = models.DateTimeField()
    tipo_de_ata = models.IntegerField()
    card = models.IntegerField()
    elemento_oculto = models.IntegerField()
    label = models.CharField(max_length=255)
    tipo = models.CharField(max_length=255)
    value = models.CharField(max_length=255)
    inserido_por = models.IntegerField()
    inserido_em = models.DateTimeField()
    status = models.IntegerField()

    class Meta:
        db_table = '"atas"."tb_atas"'

class tb_hinos(models.Model):
    id_hino	= models.AutoField(primary_key=True)
    hino = models.CharField(max_length=255)
    origem = models.IntegerField()

    class Meta:
        db_table = '"atas"."tb_hinos"'

class tb_chamados(models.Model):
    id_chamado = models.AutoField(primary_key=True)
    chamado = models.CharField(max_length=255)

    class Meta:
        db_table = '"atas"."tb_chamados"'

class vw_usuarios(models.Model):
    versao_id_membro_interno = models.AutoField(primary_key=True)
    id_membro_interno = models.IntegerField()
    nome_interno = models.CharField(max_length=255)
    telefone_individual = models.CharField(max_length=255)


    class Meta:
        db_table = '"maisferramentas"."vw_usuarios"'

class tb_atas_padrao(models.Model):
    versao_id_ata = models.AutoField(primary_key=True)
    id_ata = models.IntegerField()
    data_da_ata = models.DateTimeField()
    tipo_de_ata = models.IntegerField()
    card = models.IntegerField()
    elemento_oculto = models.IntegerField()
    label = models.CharField(max_length=255)
    tipo = models.CharField(max_length=255)
    value = models.CharField(max_length=255)
    inserido_por = models.IntegerField()
    inserido_em = models.DateTimeField()
    status = models.IntegerField()

    class Meta:
        db_table = '"atas"."tb_atas_padrao"'

class tb_cards_padrao(models.Model):
    versao_id_ata = models.AutoField(primary_key=True)
    id_ata = models.IntegerField()
    data_da_ata = models.DateTimeField()
    tipo_de_ata = models.IntegerField()
    card = models.IntegerField()
    elemento_oculto = models.IntegerField()
    label = models.CharField(max_length=255)
    tipo = models.CharField(max_length=255)
    value = models.CharField(max_length=255)
    inserido_por = models.IntegerField()
    inserido_em = models.DateTimeField()
    status = models.IntegerField()

    class Meta:
        db_table = '"atas"."tb_cards_padrao"'

class frequencia_vw_frequencia(models.Model):
    data_frequencia = models.DateTimeField()
    id_membro_interno = models.IntegerField()
    nome_interno = models.CharField(max_length=255)
    sexo = models.CharField(max_length=255)
    idade = models.IntegerField()
    id_tipo_frequencia = models.IntegerField()
    tipo_frequencia = models.CharField(max_length=255)
    status_frequencia = models.IntegerField()
    inserido_em = models.DateTimeField()
    inserido_por = models.IntegerField()
    inserido_por_nome = models.CharField(max_length=255)

    class Meta:
            db_table = '"frequencia"."vw_frequencia"'