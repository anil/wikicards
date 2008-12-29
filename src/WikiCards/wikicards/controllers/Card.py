import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from wikicards.model import Deck, Card
from google.appengine.api import users


import wikicards.lib.helpers as h

from wikicards.lib.base import BaseController, render
#from wikicards import model

from pylons.decorators.rest import dispatch_on


log = logging.getLogger(__name__)

class CardController(BaseController):

    @dispatch_on(POST="_create_me")
    def create(self):
        user = users.get_current_user()
        c.deck_id_base30 = request.params['deck_id']
        if user:
            c.deck = Deck.get_by_id_base30(c.deck_id_base30)
            c.title = " | Create A New Card"
            return render('create_card.mako')
        else:
            continue_url = h.url_for(controller="Card", action="create", deck_id=c.deck_id_base30)
            c.login_url = users.create_login_url(continue_url)
            return render('/login.mako')

    @dispatch_on(POST="_update_me")     
    def update(self, card_id):
        user = users.get_current_user()
        c.deck_id = request.params.get('referring_deck')
        
        if user:
            c.card = Card.get_by_id_base30(card_id)
            return render('/update_card.mako')
        else:
            continue_url = h.url_for(controller="Card", action="update", card_id=card_id, referring_deck = c.deck_id)
            c.login_url = users.create_login_url(continue_url)
            return render('/login.mako')
        
    def _update_me(self):
        user = users.get_current_user()
        if user:
            card = Card.get_by_id_base30(request.params.get('card_id'))
            card.term = request.params.get('term')
            card.definition = request.params.get('definition')
            card.last_edited_by = user
            card.put()
            redirect_to(h.url_for(controller="/Deck", action="view", deck_id=request.params.get('deck_id')))
        else:
            raise 'you have to be logged in'
        
    def _create_me(self):
        user = users.get_current_user()
        if user:
            #create the card
            card = Card(term=request.params.get('term'), definition=request.params.get('definition'),
                        created_by = user, last_edited_by = user)
            card.put()
            card.id_base30 = h.make_identifier(card.key().id())
            card.put()
        
            #get the deck that the term belongs to
            deck_id_base30 = request.params['deck_id']
            deck = Deck.get_by_id_base30(deck_id_base30)      
            
            if deck.cards == None:
                deck.cards = []
        
            deck.cards.append(card.key())
            deck.last_edited_by = user
            deck.put()
        
            redirect_to(h.url_for(controller='Deck', action='view', deck_id=deck_id_base30))
            
        else:
            raise 'not signed in'
