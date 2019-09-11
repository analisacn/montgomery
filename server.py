from aiohttp import web
from django import setup
from django.conf import settings

from montgomery import settings as my_settings  # not the same as django.conf.settings


async def setup_django(app):
    settings.configure(
        INSTALLED_APPS=my_settings.INSTALLED_APPS,
        DATABASES=my_settings.DATABASES)
    setup()


async def main():
    web_app = web.Application()
    web_app.on_startup.append(setup_django)
    return web_app
