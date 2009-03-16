<%inherit file="/base.mako" />
     <form method="POST" action="/deck/create">
       <div class="selfclear">
         <label>Name of Deck:</label>
         <input name="deck_name" />
       </div>
       <div>
         <input class="indented-submit" type="submit" value="create!" />
       </div>
 