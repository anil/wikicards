<%inherit file="/base.mako" />
     <div class="selfclear">
      <a href="/"><< All Decks</a>
    </div>
    <h3>
       Deck Name: ${c.deck.name}
    </h3>

    % if len(c.cards) != 0:
    <dl>
      <div class="selfclear">
        <a href="/card/create?deck_id=${c.deck_id}">Add Card</a>
      </div>
      <dt><strong>Term</strong></dt>
      <dd><strong>Definition</strong></dd>
      % for card in c.cards:
          <dt>${card.term}</dt>
          <dd>${card.definition}</dd>
      % endfor
    </dl>
    % else:
      There are currently no cards in this deck.  <a href="/card/create?deck_id=${c.deck_id}">Add one.</a>
    % endif
