<%inherit file="/base.mako" />
% if len(c.cards) == 0:
    Are you sure that you want to delete the deck?
     <form method="POST" action="${h.url_for(controller='Deck', action='delete', deck_id=c.deck_id)}">
       <div>
         <input type="submit" value="Delete" />
       </div>
     </form>
% else:
    There are cards in this deck.  If you would like to delete this deck, please delete all of the cards
    in it first!
% endif

