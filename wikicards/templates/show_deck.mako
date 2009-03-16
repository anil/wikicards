<%inherit file="/base.mako" />
     <div class="selfclear">
      <a href="/"><< All Decks</a>
    </div>
    <h3>
       Deck Name: ${c.deck.name} ${c.id_base30}
    </h3>

    % if len(c.cards) != 0:
      <table border="1">
      <tr>
        <td class="term heading">Term</td>
        <td class="definition heading">Definition</td>
        <td class="admin heading">Admin</td>
      % for card in c.cards:
        <tr>  
          <td class="term">${card.term}</td>
          <td class="definition">${card.definition}</td>
          <td class="admin">
             <a href="${h.url_for(controller="/Card", action="update", card_id=card.id_base30, referring_deck=c.deck_id)}">Edit</a> / 
             <a href="${h.url_for(controller="/Card", action="view", card_id=card.id_base30, referring_deck=c.deck_id)}">History</a>
             % if c.is_admin:
             / <a href="${h.url_for(controller="/Card", action="delete", card_id=card.id_base30, referring_deck=c.deck_id)}">Delete</a>
             % endif
           </td>
        </tr>
      % endfor
    </table>
    <div class="selfclear" id="deck-actions">
      <h4>Deck Actions</h4>
        <div>
           <a href="/card/create?deck_id=${c.deck_id}">Add Card</a>
        </div>
        <div>
          <a href="${h.url_for(controller='Deck', action='quiz', deck_id=c.deck_id)}">Take a quiz!</a>
        </div>
        % if c.is_admin:
        <div>
          <a href="${h.url_for(controller='Deck', action='delete', deck_id=c.deck_id)}">Delete the deck.</a>
        </div>
        % endif
    </div>
    % else:
      There are currently no cards in this deck.  <a href="/card/create?deck_id=${c.deck_id}">Add one.</a>
      <div class="selfclear" id="deck-actions">
      <h4>Deck Actions</h4>
       % if c.is_admin:
       <div>
          <a href="${h.url_for(controller='Deck', action='delete', deck_id=c.deck_id)}">Delete the deck.</a>
       </div>
       % endif
       </div>
    % endif
