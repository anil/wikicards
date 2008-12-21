<%inherit file="/base.mako" />
     <div class="selfclear">
      <a href="/"><< All Decks</a>
    </div>
    <h3>
       Deck Name: ${c.deck.name} ${c.id_base30}
    </h3>

    % if len(c.cards) != 0:
      <div class="selfclear">
        <a href="/card/create?deck_id=${c.deck_id}">Add Card</a>
      </div>
      <table border="1">
      <tr>
        <td class="term heading">Term</td>
        <td class="definition heading">Definition</td>
      % for card in c.cards:
        <tr>  
          <td class="term">${card.term}</td>
          <td class="definition">${card.definition}</td>
        </tr>
      % endfor
    </table>
    % else:
      There are currently no cards in this deck.  <a href="/card/create?deck_id=${c.deck_id}">Add one.</a>
    % endif
