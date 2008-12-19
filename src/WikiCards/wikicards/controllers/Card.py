import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from wikicards.model import Deck, Card

import wikicards.lib.helpers as h

from wikicards.lib.base import BaseController, render
#from wikicards import model

from pylons.decorators.rest import dispatch_on


log = logging.getLogger(__name__)

class CardController(BaseController):

    @dispatch_on(POST="_create_me")
    def create(self):
       c.deck_id = int(request.params['deck_id'])
       c.deck = Deck.get_by_id(c.deck_id)
       c.title = " | Create A New Card"
       return render('create_card.mako')
       
    def _create_me(self):
        #create the card
        card = Card(term=request.params.get('term'), definition=request.params.get('definition'))
        card.put()
        
        #get the deck that the term belongs to
        deck_id = int(request.params['deck_id'])
        deck = Deck.get_by_id(deck_id)
        
            
        if deck.cards == None:
            deck.cards = []
        
        deck.cards.append(card.key())
        deck.put()
        
        redirect_to(h.url_for(controller='Deck', action='view', deck_id=deck_id))
