<%inherit file="/base.mako" />
    <div class="flash notice">Pressing delete will delete this card and all of its version history!</div>
     <form method="POST" action="${h.url_for(controller='Card', action='delete', card_id=c.card_id)}">
       <div class="selfclear">
         <label>Click to delete</label>
         <input type="submit" value="Delete" />
       </div>
       <input type="hidden" name="deck_id" value="${c.deck_id}" />
     </form>

