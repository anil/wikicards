<%inherit file="/base.mako" />
    <h3>
     Deck Name: ${c.deck.name}
    </h3>
    <form action="/card/create" method="POST">
     <fieldset>
        <div class="selfclear">
            <label for="term">Term:</label>
            <input size="77" type="text" name="term" />
        </div>
        <div class="selfclear">
            <label for="term">Definition:</label>
            <textarea rows="20" cols="80" name="definition"></textarea>
        </div>
        <div class="selfclear">
            <input class="indented-submit" type="submit" value="Create!" />
        </div>
      </fieldset>
        <input type="hidden" name="deck_id" value="${c.deck_id_base30}" />
     </form>

