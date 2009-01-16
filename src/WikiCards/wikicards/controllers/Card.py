import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from wikicards.model import Deck, Card
from google.appengine.ext import db
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
            c.deck = Deck.get_current_by_id_base30(c.deck_id_base30)
            c.title = " | Create A New Card"
            return render('create_card.mako')
        else:
            continue_url = h.url_for(controller="Card", action="create", deck_id=c.deck_id_base30)
            c.login_url = users.create_login_url(continue_url)
            return render('/login.mako')
            
    def view(self, card_id):
        c.cards = Card.get_all_by_id_base30(card_id)
        c.title = " | Card Revision History"
        c.num_cards = len(c.cards)
        c.deck_id = request.params.get('referring_deck')
        return render('/view_card.mako')
    
    @dispatch_on(POST="_update_me")     
    def revert(self, card_id):
        revision_number = request.params.get('revision')
        c.current_card = Card.get_current_by_id_base30(card_id)
        c.title = "| " + "Revert Card"
        c.old_card = Card.get_revision_by_id_base30(card_id, int(revision_number))
        try:
            c.deck_id = request.params.get('referring_deck')
        except KeyError:
            c.deck_id = None
        return render('/revert_card.mako')

    @dispatch_on(POST="_update_me")     
    def update(self, card_id):
        user = users.get_current_user()
        
        try:
            c.deck_id = request.params['referring_deck']
        except KeyError:
            c.deck_id = None
        
        if user:
            c.card = Card.get_current_by_id_base30(card_id)
            c.title = "| " + "Update Card"
            return render('/update_card.mako')
        else:
            continue_url = h.url_for(controller="Card", action="update", card_id=card_id, referring_deck = c.deck_id)
            c.login_url = users.create_login_url(continue_url)
            return render('/login.mako')
        
    def _update_me(self):
        user = users.get_current_user()
        if user:
            card_old = Card.get_current_by_id_base30(request.params.get('card_id'))
            card_new = Card(term = request.params.get('term'), definition = request.params.get('definition'),
                            created_by = user, last_edited_by = user, id_base30 = card_old.id_base30,
                            decks = card_old.decks)
            card_new.put()

            deck_keys = card_old.decks
            # Remove the old revision of the card from the deck
            # and add the new revision of the card into the deck
            for deck_key in deck_keys:
                deck = db.get(deck_key)
                deck.cards.append(card_new.key())
                deck.cards.remove(card_old.key())
                deck.last_edited_by = user
                deck.put()
            
            try:
                referring_deck_id = request.params['deck_id']
                redirect_to(h.url_for(controller="/Deck", action="view", deck_id=referring_deck_id))
            except KeyError:
                redirect_to(h.url_for(controller='Card', action="view", card_id=card_new.id_base30))
            
        else:
            raise 'you have to be logged in'
        
    def _create_me(self):
        user = users.get_current_user()
        if user:
            
            # make sure that there is a deck in the query string.
            try:
                deck_id_base30 = request.params['deck_id']
            except KeyError:
                raise 'test'
                
            #get the deck that the term belongs to
            deck = Deck.get_current_by_id_base30(deck_id_base30)
            
            # create a list of decks that the card is contained in
            # the cards store of list of who their parent decks are
            decks = []
            decks.append(deck.key())
            
            card = Card(term=request.params.get('term'), definition=request.params.get('definition'),
                        created_by = user, last_edited_by = user, decks=decks)
            card.put()
            card.id_base30 = h.make_identifier(card.key().id())
            card.put()
           
            # the deck stores a list of the cards that are contained in it
            if deck.cards == None:
                deck.cards = []
        
            deck.cards.append(card.key())
            deck.last_edited_by = user
            deck.put()
        
            redirect_to(h.url_for(controller='Deck', action='view', deck_id=deck_id_base30))
            
        else:
            raise 'not signed in'
