<%inherit file="/base.mako" />
    <h4>Available Decks</h4>
    <ul>
	% for deck in c.decks:
        <li><a href="/deck/${deck.id_base30}">${deck.name}</a></li>
	% endfor
    </ul>
    <div class="selfclear">
        Don't find a deck you can use? <a href="/deck/create">Create a New Deck</a>
    </div>

