<%inherit file="/base.mako" />
    Are you sure that you want to delete this card and all of its version history?
    This card will be deleted from every deck that it is a part of!
     <form method="POST" action="${h.url_for(controller='Card', action='delete', card_id=c.card_id)}">
       <div>
         <input type="submit" value="Delete" />
       </div>
       <input type="hidden" name="deck_id" value="${c.deck_id}" />
     </form>

