from django.db import models
from django.db.models import F, Func, Value, CharField, IntegerField, DateField
from django.db.models.functions import Cast
from datetime import date
from django.db import models, connection

class tb_data_users(models.Model):
    id_tb_data_users=models.AutoField(primary_key=True)
    marriage_status = models.CharField()
    spouseOfHeadOfHouseSort = models.IntegerField()
    birth_year = models.CharField()
    temple_recommend_type = models.CharField()
    mission_language = models.CharField()
    is_bic = models.CharField()
    visiting_teachers = models.CharField()
    moveInDateSort = models.CharField()
    ageSort = models.IntegerField()
    temple_recommend_status = models.CharField()
    potential_institute_student = models.CharField()
    spouse_of_head_of_house = models.CharField()
    is_sealed_to_parents = models.CharField()
    priesthoodOfficeSort = models.IntegerField()
    templeRecommendExpirationDateSort = models.CharField()
    birthMonthSort = models.IntegerField()
    is_sealed_to_a_spouse = models.CharField()
    is_endowed = models.CharField()
    sealing_to_spouse = models.CharField()
    sealingToSpouseSort = models.CharField()
    birth_date = models.CharField()
    maiden_name = models.CharField()
    institute_status = models.CharField()
    is_sealed_to_current_spouse = models.CharField()
    has_visiting_teachers = models.CharField()
    id =  models.BigIntegerField()
    priesthood = models.CharField()
    birthday = models.CharField()
    is_divorced = models.CharField()
    unit = models.CharField()
    sealing_to_parents = models.CharField()
    callings_with_date_sustained_and_set_apart = models.CharField()
    individual_phone = models.CharField()
    birth_country = models.CharField()
    confirmation_date = models.CharField()
    temple_recommend_expiration_date = models.CharField()
    birthplace = models.CharField()
    birth_month = models.CharField()
    endowment_status = models.CharField()
    maidenNameSort = models.IntegerField()
    sealingToParentsSort = models.CharField()
    unit_abbreviation = models.CharField()
    head_of_house_and_spouse = models.CharField()
    is_married = models.CharField()
    class_assignment = models.CharField()
    seminary_status = models.CharField()
    individual_email = models.CharField()
    is_single = models.CharField()
    callings_with_date_sustained = models.CharField()
    is_widowed = models.CharField()
    groupByUnitName = models.CharField()
    is_sealed_to_prior_spouse = models.CharField()
    callings = models.CharField()
    head_of_house = models.CharField()
    is_convert = models.CharField()
    spouse_name = models.CharField()
    ordination_date = models.CharField()
    is_accountable = models.CharField()
    fullNameSort = models.IntegerField()
    birth_day = models.CharField()
    move_in_date = models.CharField()
    baptismDateSort = models.CharField()
    is_returned_missionary = models.CharField()
    household_position = models.CharField()
    headOfHouseSort = models.IntegerField()
    preferred_name = models.CharField()
    address_street_1 = models.CharField()
    address_street_2 = models.CharField()
    full_name = models.CharField()
    gender = models.CharField()
    headOfHouseAndSpouseSort = models.IntegerField()
    mission_country = models.CharField()
    age = models.CharField()
    address_country = models.CharField()
    home_teachers = models.CharField()
    potential_seminary_student = models.CharField()
    has_home_teacher = models.CharField()
    is_attending_seminary = models.CharField()
    endowment_date = models.CharField()
    birthDaySort = models.IntegerField()
    is_attending_institute = models.CharField()
    has_children = models.CharField()
    address_city = models.CharField()
    baptism_date = models.CharField()
    birthDateSort = models.CharField()
    marriage_date = models.CharField()
    address_state = models.CharField()
    endowmentDateSort = models.CharField()
    priesthood_office = models.CharField()
    spouseNameSort = models.IntegerField()
    confirmationDateSort = models.CharField()
    preferredNameSort = models.IntegerField()
    address_postal_code = models.CharField()
    marriageDateSort = models.CharField()
    ordainedDateSort = models.CharField()
    inserted_date = models.CharField()
    inserted_by = models.IntegerField()

    class Meta:
        db_table = '"maisferramentas"."tb_data_users"'
        managed = False

class tb_participants(models.Model):
  id_tb_participants=models.AutoField(primary_key=True)
  name = models.CharField()
  age = models.IntegerField()
  transactionParticipantId = models.BigIntegerField()
  membershipId = models.CharField()
  unitNumber = models.IntegerField()
  member = models.BooleanField()
  inserted_date = models.CharField()
  inserted_by = models.IntegerField()

  class Meta:
    db_table = '"maisferramentas"."tb_participants"' 


class tb_members_moved_out(models.Model):
  id_tb_members_moved_out = models.AutoField(primary_key=True)
  name = models.CharField()
  birthDate = models.CharField()
  moveDate = models.CharField()  
  priorUnit = models.CharField()
  nextUnitName = models.CharField()
  nextUnitNumber = models.CharField()
  deceased = models.CharField()
  inserted_date = models.CharField()
  inserted_by = models.IntegerField()

  class Meta:
    db_table = '"maisferramentas"."tb_members_moved_out"'