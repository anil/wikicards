import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.rest import dispatch_on
from google.appengine.api import users

from google.appengine.ext import db

import wikicards.lib.helpers as h
from wikicards.lib.base import BaseController, render
from wikicards.model import Deck, Card

log = logging.getLogger(__name__)

class AdminController(BaseController):

    def index(self):
        return render('/about.mako')
