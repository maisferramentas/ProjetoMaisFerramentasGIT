from django.db import models
from django.db.models import F, Func, Value, CharField, IntegerField, DateField
from django.db.models.functions import Cast
from datetime import date
from django.db import models, connection

class vw_aniversariantes(models.Model):
    id_membro_interno = models.AutoField(primary_key=True)
    nome_interno = models.CharField(max_length=255)
    organizacao	= models.CharField(max_length=255)
    data_aniversário = models.CharField(max_length=255)
    ano_do_nascimento = models.IntegerField()
    mes_aniversario = models.CharField(max_length=255)
    dia_aniversario = models.CharField(max_length=255)
    idade  = models.IntegerField()
    telefone_individual = models.CharField(max_length=255)
    endereco = models.CharField(max_length=255)
        
    class Meta:
        db_table = '"aniversariantes"."vw_aniversariantes"'
        managed = False