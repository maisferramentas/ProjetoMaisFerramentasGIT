# Generated by Django 5.0 on 2024-06-04 20:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MaisFerramentas', '0002_model_registrar_frequencia_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='tb_data_user',
            fields=[
                ('marriage_status', models.CharField(blank=True, max_length=255, null=True)),
                ('spouseOfHeadOfHouseSort', models.IntegerField(blank=True, null=True)),
                ('birth_year', models.CharField(blank=True, max_length=4, null=True)),
                ('temple_recommend_type', models.CharField(blank=True, max_length=255, null=True)),
                ('mission_language', models.CharField(blank=True, max_length=255, null=True)),
                ('is_bic', models.CharField(blank=True, max_length=3, null=True)),
                ('visiting_teachers', models.CharField(blank=True, max_length=255, null=True)),
                ('moveInDateSort', models.CharField(blank=True, max_length=8, null=True)),
                ('ageSort', models.IntegerField(blank=True, null=True)),
                ('temple_recommend_status', models.CharField(blank=True, max_length=255, null=True)),
                ('potential_institute_student', models.CharField(blank=True, max_length=3, null=True)),
                ('spouse_of_head_of_house', models.CharField(blank=True, max_length=255, null=True)),
                ('is_sealed_to_parents', models.CharField(blank=True, max_length=3, null=True)),
                ('priesthoodOfficeSort', models.IntegerField(blank=True, null=True)),
                ('templeRecommendExpirationDateSort', models.CharField(blank=True, max_length=8, null=True)),
                ('birthMonthSort', models.IntegerField(blank=True, null=True)),
                ('is_sealed_to_a_spouse', models.CharField(blank=True, max_length=3, null=True)),
                ('is_endowed', models.CharField(blank=True, max_length=3, null=True)),
                ('sealing_to_spouse', models.CharField(blank=True, max_length=255, null=True)),
                ('sealingToSpouseSort', models.IntegerField(blank=True, null=True)),
                ('birth_date', models.CharField(blank=True, max_length=11, null=True)),
                ('maiden_name', models.CharField(blank=True, max_length=255, null=True)),
                ('institute_status', models.CharField(blank=True, max_length=255, null=True)),
                ('is_sealed_to_current_spouse', models.CharField(blank=True, max_length=3, null=True)),
                ('has_visiting_teachers', models.CharField(blank=True, max_length=3, null=True)),
                ('id', models.BigIntegerField(primary_key=True, serialize=False)),
                ('priesthood', models.CharField(blank=True, max_length=255, null=True)),
                ('birthday', models.CharField(blank=True, max_length=10, null=True)),
                ('is_divorced', models.CharField(blank=True, max_length=3, null=True)),
                ('unit', models.CharField(blank=True, max_length=255, null=True)),
                ('sealing_to_parents', models.CharField(blank=True, max_length=255, null=True)),
                ('callings_with_date_sustained_and_set_apart', models.CharField(blank=True, max_length=255, null=True)),
                ('individual_phone', models.CharField(blank=True, max_length=20, null=True)),
                ('birth_country', models.CharField(blank=True, max_length=255, null=True)),
                ('confirmation_date', models.CharField(blank=True, max_length=11, null=True)),
                ('temple_recommend_expiration_date', models.CharField(blank=True, max_length=11, null=True)),
                ('birthplace', models.CharField(blank=True, max_length=255, null=True)),
                ('birth_month', models.CharField(blank=True, max_length=10, null=True)),
                ('endowment_status', models.CharField(blank=True, max_length=20, null=True)),
                ('maidenNameSort', models.IntegerField(blank=True, null=True)),
                ('sealingToParentsSort', models.IntegerField(blank=True, null=True)),
                ('unit_abbreviation', models.CharField(blank=True, max_length=255, null=True)),
                ('head_of_house_and_spouse', models.CharField(blank=True, max_length=255, null=True)),
                ('is_married', models.CharField(blank=True, max_length=3, null=True)),
                ('class_assignment', models.CharField(blank=True, max_length=255, null=True)),
                ('seminary_status', models.CharField(blank=True, max_length=255, null=True)),
                ('individual_email', models.CharField(blank=True, max_length=255, null=True)),
                ('is_single', models.CharField(blank=True, max_length=3, null=True)),
                ('callings_with_date_sustained', models.CharField(blank=True, max_length=255, null=True)),
                ('is_widowed', models.CharField(blank=True, max_length=3, null=True)),
                ('groupByUnitName', models.CharField(blank=True, max_length=255, null=True)),
                ('is_sealed_to_prior_spouse', models.CharField(blank=True, max_length=3, null=True)),
                ('callings', models.CharField(blank=True, max_length=255, null=True)),
                ('head_of_house', models.CharField(blank=True, max_length=255, null=True)),
                ('is_convert', models.CharField(blank=True, max_length=3, null=True)),
                ('spouse_name', models.CharField(blank=True, max_length=255, null=True)),
                ('ordination_date', models.CharField(blank=True, max_length=11, null=True)),
                ('is_accountable', models.CharField(blank=True, max_length=3, null=True)),
                ('fullNameSort', models.IntegerField(blank=True, null=True)),
                ('birth_day', models.CharField(blank=True, max_length=2, null=True)),
                ('move_in_date', models.CharField(blank=True, max_length=11, null=True)),
                ('baptismDateSort', models.CharField(blank=True, max_length=8, null=True)),
                ('is_returned_missionary', models.CharField(blank=True, max_length=3, null=True)),
                ('household_position', models.CharField(blank=True, max_length=50, null=True)),
                ('headOfHouseSort', models.IntegerField(blank=True, null=True)),
                ('preferred_name', models.CharField(blank=True, max_length=255, null=True)),
                ('address_street_1', models.CharField(blank=True, max_length=255, null=True)),
                ('address_street_2', models.CharField(blank=True, max_length=255, null=True)),
                ('full_name', models.CharField(blank=True, max_length=255, null=True)),
                ('gender', models.CharField(blank=True, max_length=1, null=True)),
                ('headOfHouseAndSpouseSort', models.IntegerField(blank=True, null=True)),
                ('mission_country', models.CharField(blank=True, max_length=255, null=True)),
                ('age', models.CharField(blank=True, max_length=3, null=True)),
                ('address_country', models.CharField(blank=True, max_length=255, null=True)),
                ('home_teachers', models.CharField(blank=True, max_length=255, null=True)),
                ('potential_seminary_student', models.CharField(blank=True, max_length=3, null=True)),
                ('has_home_teacher', models.CharField(blank=True, max_length=3, null=True)),
                ('is_attending_seminary', models.CharField(blank=True, max_length=3, null=True)),
                ('endowment_date', models.CharField(blank=True, max_length=11, null=True)),
                ('birthDaySort', models.IntegerField(blank=True, null=True)),
                ('is_attending_institute', models.CharField(blank=True, max_length=3, null=True)),
                ('has_children', models.CharField(blank=True, max_length=3, null=True)),
                ('address_city', models.CharField(blank=True, max_length=255, null=True)),
                ('baptism_date', models.CharField(blank=True, max_length=11, null=True)),
                ('birthDateSort', models.CharField(blank=True, max_length=8, null=True)),
                ('marriage_date', models.CharField(blank=True, max_length=11, null=True)),
                ('address_state', models.CharField(blank=True, max_length=255, null=True)),
                ('endowmentDateSort', models.CharField(blank=True, max_length=8, null=True)),
                ('priesthood_office', models.CharField(blank=True, max_length=255, null=True)),
                ('spouseNameSort', models.IntegerField(blank=True, null=True)),
                ('confirmationDateSort', models.CharField(blank=True, max_length=8, null=True)),
                ('preferredNameSort', models.IntegerField(blank=True, null=True)),
                ('address_postal_code', models.CharField(blank=True, max_length=10, null=True)),
                ('marriageDateSort', models.CharField(blank=True, max_length=8, null=True)),
                ('ordainedDateSort', models.CharField(blank=True, max_length=8, null=True)),
            ],
            options={
                'db_table': '"maisferramentas"."tb_data_user"',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='vw_aniversariantes',
            fields=[
                ('id_membro_interno', models.AutoField(primary_key=True, serialize=False)),
                ('nome_interno', models.CharField(max_length=255)),
                ('organizacao', models.CharField(max_length=255)),
                ('data_aniversário', models.CharField(max_length=255)),
                ('ano_do_nascimento', models.IntegerField()),
                ('mes_aniversario', models.CharField(max_length=255)),
                ('dia_aniversario', models.CharField(max_length=255)),
                ('idade', models.IntegerField()),
                ('telefone_individual', models.CharField(max_length=255)),
                ('endereco', models.CharField(max_length=255)),
                ('sexo', models.CharField(max_length=255)),
            ],
            options={
                'db_table': '"aniversariantes"."vw_aniversariantes"',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='frequencia_vw_frequencia',
            fields=[
                ('id_membro_interno', models.AutoField(primary_key=True, serialize=False)),
                ('data_frequencia', models.DateTimeField()),
                ('nome_interno', models.CharField(max_length=255)),
                ('sexo', models.CharField(max_length=255)),
                ('idade', models.IntegerField()),
                ('id_tipo_frequencia', models.IntegerField()),
                ('tipo_frequencia', models.CharField(max_length=255)),
                ('status_frequencia', models.IntegerField()),
                ('inserido_em', models.DateTimeField()),
                ('inserido_por', models.IntegerField()),
                ('inserido_por_nome', models.CharField(max_length=255)),
            ],
            options={
                'db_table': '"frequencia"."vw_frequencia"',
            },
        ),
        migrations.CreateModel(
            name='model_ata_no_banco',
            fields=[
                ('versao_id_ata', models.AutoField(primary_key=True, serialize=False)),
                ('id_ata', models.IntegerField()),
                ('data_da_ata', models.DateTimeField()),
                ('tipo_de_ata', models.IntegerField()),
                ('card', models.IntegerField()),
                ('elemento_oculto', models.IntegerField()),
                ('label', models.CharField(max_length=255)),
                ('tipo', models.CharField(max_length=255)),
                ('value', models.CharField(max_length=255)),
                ('inserido_por', models.IntegerField()),
                ('inserido_em', models.DateTimeField()),
                ('status', models.IntegerField()),
            ],
            options={
                'db_table': '"atas"."tb_atas"',
            },
        ),
        migrations.CreateModel(
            name='tb_atas_padrao',
            fields=[
                ('versao_id_ata', models.AutoField(primary_key=True, serialize=False)),
                ('id_ata', models.IntegerField()),
                ('data_da_ata', models.DateTimeField()),
                ('tipo_de_ata', models.IntegerField()),
                ('card', models.IntegerField()),
                ('elemento_oculto', models.IntegerField()),
                ('label', models.CharField(max_length=255)),
                ('tipo', models.CharField(max_length=255)),
                ('value', models.CharField(max_length=255)),
                ('inserido_por', models.IntegerField()),
                ('inserido_em', models.DateTimeField()),
                ('status', models.IntegerField()),
            ],
            options={
                'db_table': '"atas"."tb_atas_padrao"',
            },
        ),
        migrations.CreateModel(
            name='tb_cards_padrao',
            fields=[
                ('versao_id_ata', models.AutoField(primary_key=True, serialize=False)),
                ('id_ata', models.IntegerField()),
                ('data_da_ata', models.DateTimeField()),
                ('tipo_de_ata', models.IntegerField()),
                ('card', models.IntegerField()),
                ('elemento_oculto', models.IntegerField()),
                ('label', models.CharField(max_length=255)),
                ('tipo', models.CharField(max_length=255)),
                ('value', models.CharField(max_length=255)),
                ('inserido_por', models.IntegerField()),
                ('inserido_em', models.DateTimeField()),
                ('status', models.IntegerField()),
            ],
            options={
                'db_table': '"atas"."tb_cards_padrao"',
            },
        ),
        migrations.CreateModel(
            name='tb_chamados',
            fields=[
                ('id_chamado', models.AutoField(primary_key=True, serialize=False)),
                ('chamado', models.CharField(max_length=255)),
            ],
            options={
                'db_table': '"atas"."tb_chamados"',
            },
        ),
        migrations.CreateModel(
            name='tb_hinos',
            fields=[
                ('id_hino', models.AutoField(primary_key=True, serialize=False)),
                ('hino', models.CharField(max_length=255)),
                ('origem', models.IntegerField()),
            ],
            options={
                'db_table': '"atas"."tb_hinos"',
            },
        ),
        migrations.CreateModel(
            name='vw_usuarios',
            fields=[
                ('versao_id_membro_interno', models.AutoField(primary_key=True, serialize=False)),
                ('id_membro_interno', models.IntegerField()),
                ('nome_interno', models.CharField(max_length=255)),
                ('telefone_individual', models.CharField(max_length=255)),
            ],
            options={
                'db_table': '"maisferramentas"."vw_usuarios"',
            },
        ),
    ]
