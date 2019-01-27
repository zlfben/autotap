#!/bin/python/
"""
WSGI config for backend project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/2.0/howto/deployment/wsgi/
"""

import os,sys

sys.path.append('/data/superifttt')
sys.path.append('/data/superiftttdjango')
sys.path.append('/data/superifttt/djangodeployment')
sys.path.append('/data/superifttt/djangodeployment/venv/lib/python3.6/site-packages')


from django.core.wsgi import get_wsgi_application

os.environ['DJANGO_SETTINGS_MODULE'] = "backend.settings"

application = get_wsgi_application()
