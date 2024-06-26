from __future__ import print_function
from django.core.serializers import serialize
from django.http import JsonResponse
# from .models import Frequencia
from django.shortcuts import render, redirect
from django.forms.models import model_to_dict
from django.db.models import Q 
from datetime import date
from django.utils import timezone
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import never_cache
from django.http import HttpResponse
from django.template.loader import render_to_string 
import json
import os
import subprocess
from django.http import HttpResponse
from django.conf import settings



# Robo
import time
import json
import requests
import os
import json
from django.http import JsonResponse
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.chrome.options import Options
from .utils import *
from .views import enviar_email
from .views import *


#################
# Hora Atual
#################
import pytz
# Obtém o tempo atual em UTC
now_utc = timezone.now()
# Converte para o fuso horário desejado (por exemplo, 'America/Sao_Paulo')
timezone_sao_paulo = pytz.timezone('America/Sao_Paulo')
now_sao_paulo = now_utc.astimezone(timezone_sao_paulo)
# Formata a data e hora ajustadas
timestamps = now_sao_paulo.strftime('%Y-%m-%d %H:%M:%S.%f')

