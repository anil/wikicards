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

class DeckController(BaseController):

    def index(self):
        c.decks = Deck.all()
        return render('/show_decks.mako')

    def view(self, deck_id=None):
        c.is_admin = users.is_current_user_admin()
        c.deck = Deck.get_current_by_id_base30(deck_id)
        c.cards = Card.get(c.deck.cards)
        c.title = " | " + c.deck.name
        return render('/show_deck.mako')
        
    @dispatch_on(POST="_delete_me")     
    def delete(self, deck_id=None):
        if users.is_current_user_admin():
            c.deck = Deck.get_current_by_id_base30(deck_id)
            c.cards = Card.get(c.deck.cards)
            c.title = " | " + c.deck.name
            return render('/delete_deck.mako')
        else:
            #XXX Proper http error here
            raise 'error'
        
    def _delete_me(self, deck_id=None):
        if users.is_current_user_admin():
            deck = Deck.get_all_by_id_base30(deck_id)
            db.delete(deck)
            redirect_to(h.url_for("/"))
        else:
            abort(401)
        
    def xml(self, deck_id=None):
        response.headers['Content-type'] = "Content-Type: application/xml; charset=utf-8" 
        c.deck = Deck.get_current_by_id_base30(deck_id)
        c.cards = Card.get(c.deck.cards)                    
        return render('/xml_deck.mako')
        
    def quiz(self, deck_id=None):
        c.deck = Deck.get_current_by_id_base30(deck_id)
        c.cards = Card.get(c.deck.cards)
        c.title = "| " + c.deck.name + " Quiz"            
        return render('quiz_deck.mako')

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
