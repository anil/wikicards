<%inherit file="/base.mako" />
<script type="text/javascript">
 $(document).ready(function() {
     cards = $(".card").children();
     num_cards = cards.length
     index = 0;
         
     $("#dialog").dialog({
			bgiframe: true,
			resizable: false,
			height:475,
			width: 700,
			modal: true,
			overlay: {
				backgroundColor: '#000',
				opacity: 0.5
			},
			buttons: {
				'Next Card': function() {
					index = index + 2;
					if (index == num_cards) {
					   index = 0;   
				    }
				    $("#card-term").show();
				    $("#card-def").hide();
                    $("#card-term").html(cards[index].innerHTML);
                    $("#card-def").html(cards[index+1].innerHTML);
				},
				'Previous Card': function() {
				    index = index - 2;				    
				    if (index < 0) {
					   index = num_cards - 2;   
				    }
				    $("#card-term").show();
				    $("#card-def").hide();
				    $("#card-term").html(cards[index].innerHTML);
                    $("#card-def").html(cards[index+1].innerHTML);
					
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

<div id="dialog" title="${c.deck.name}">
    <p id="card-term">${c.cards[0].term}</p>
    <p id="card-def">${c.cards[0].definition}</p>
</div>


<%def name="extra_head()">
  <script type="text/javascript" src="/jquery.min.js"></script>
  <script type="text/javascript" src="/jquery-ui.min.js"></script>
  <link type="text/css" href="/ui.all.css" rel="stylesheet" />
</%def>