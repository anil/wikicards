<%inherit file="/base.mako" />
    <h3>
     Deck Name: ${c.deck.name}
    </h3>
    <form action="/card/create" method="POST">
     <fieldset>
        <div class="selfclear">
            <label for="term">Term:</label>
            <input type="text" name="term" />
        </div>
        <div class="selfclear">
            <label for="term">Definition:</label>
            <textarea name="definition"></textarea>
        </div>
        <div class="selfclear">
            <input class="indented-submit" type="submit" value="Create!" />
        </div>
      </fieldset>
        <input type="hidden" name="deck_id" value="${c.deck_id}" />
     </form>

