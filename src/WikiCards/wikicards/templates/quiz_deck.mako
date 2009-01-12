<%inherit file="/base.mako" />
<script type="text/javascript">
 $(document).ready(function() {     
     $("#dialog").dialog({
			bgiframe: true,
			resizable: false,
			height:500,
			modal: true,
			overlay: {
				backgroundColor: '#000',
				opacity: 0.5
			},
			buttons: {
				'Next Card': function() {
					$(this).dialog('close');
				},
				'Previous Card': function() {
					$(this).dialog('close');
				},
				'Flip Card':function() {
				    $("#card-term").toggle();
				    $("#card-def").toggle();   
			    }
			}
		});	
 });
</script>
Quiz for deck: ${c.deck.name}

<div id="card-list">
  % for card in c.cards:
  <div class="card">
    <div class="term">
      ${card.term}
    </div>
    <div class="definition">
      ${card.definition}
    </div>
  </div>
  % endfor
</div>

<div id="dialog" title="Quiz for the Deck">
    <p id="card-term">${c.cards[0].term}</p>
    <p id="card-def">${c.cards[0].definition}</p>
</div>


<%def name="extra_head()">
  <script type="text/javascript" src="/jquery.min.js"></script>
  <script type="text/javascript" src="/jquery-ui.min.js"></script>
  <link type="text/css" href="/ui.all.css" rel="stylesheet" />
</%def>