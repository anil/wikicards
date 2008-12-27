<%inherit file="/base.mako" />
<form action="#" method="POST">
 <fieldset>
    <div class="selfclear">
        <label for="term">Term:</label>
        <input type="text" name="term" value="${c.card.term}" />
    </div>
    <div class="selfclear">
        <label for="term">Definition:</label>
        <textarea name="definition">${c.card.definition}</textarea>
    </div>
    <div class="selfclear">
        <input class="indented-submit" type="submit" value="Update!" />
    </div>
  </fieldset>
    <input type="hidden" name="card_id" value="${c.card.id_base30}" />
    <input type="hidden" name="deck_id" value="${c.deck_id}" />
 </form>