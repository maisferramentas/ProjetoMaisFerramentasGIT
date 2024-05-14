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