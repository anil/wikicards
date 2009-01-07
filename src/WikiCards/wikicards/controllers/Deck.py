import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.rest import dispatch_on
from google.appengine.api import users

from google.appengine.ext import db

import wikicards.lib.helpers as h
from wikicards.lib.base import BaseController, render
from wikicards.model import Deck

log = logging.getLogger(__name__)

class DeckController(BaseController):

    def index(self):
        c.decks = Deck.all()
        return render('/show_decks.mako')

    def view(self, deck_id=None):
        c.deck = Deck.get_current_by_id_base30(deck_id)
        card_keys = c.deck.cards
                
        c.cards = []
        for key in card_keys:
            c.cards.append(db.get(key))
            
        c.title = " | " + c.deck.name

        return render('/show_deck.mako')

    def _create_me(self):
        user = users.get_current_user()
        if user:
            deck = Deck(name=request.params.get('deck_name', ''), created_by = user, last_edited_by = user)
            deck.put()
            deck.id_base30 = h.make_identifier(deck.key().id())
            deck.put()
            redirect_to(h.url_for(controller='Deck', action='view', deck_id=deck.id_base30))
        else:
            raise 'not logged in'

    @dispatch_on(POST="_create_me")
    def create(self):
        user = users.get_current_user()
        if user:
            c.title = " | Create a New Deck"
            return render('/create_deck.mako')
        else:
            c.login_url = users.create_login_url(h.url_for(controller="Deck", action="create"))
            return render('/login.mako')
