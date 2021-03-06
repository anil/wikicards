<%inherit file="/base.mako" />
<script type="text/javascript">
 $(document).ready(function() {
     cards = $(".card").children();
     num_cards = cards.length
     index = 0;
     dialog = null;
    
     
     function change_card_description() {
        if ($("#card-description").html() == "Answer:") {
              $("#card-description").html('Question:');
        }
        else {
            $("#card-description").html('Answer:');  
        }
     }
     
     function change_card() {
         $("#card-description").html('Question:');
         $("#card-term").show();
		 $("#card-def").hide();
         $("#card-term").html(cards[index].innerHTML);
         $("#card-def").html(cards[index+1].innerHTML);
     }
     
     $("#relaunch-link").click (    
       function () {
           $("#dialog").dialog('open');
       });
     
     function launch_dialog() {
         
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

                    change_card();

                    },
                'Previous Card': function() {
                    index = index - 2;				    
                    if (index < 0) {
                      index = num_cards - 2;   
                     }

                     change_card();

                  },
                 'Flip Card':function() {
                     $("#card-term").toggle();
                     $("#card-def").toggle();
                     change_card_description();
                  }
             }
          });	
		
	 }
	
	 launch_dialog();

 });
</script>
Quiz for ${c.deck.name} deck.  Click here to relaunch the <a href="#" id="relaunch-link">quiz</a>.

<div id="card-list">
  % for card in c.cards:
  <div class="card">
      % if c.reverse:
          <div class="definition">
          ${card.definition}
      % else:
          <div class="term">
          ${card.term} 
      % endif
    </div>
    % if c.reverse:
        <div class="term">
        ${card.term}
    % else:
        <div class="definition">
        ${card.definition} 
    % endif
    </div>
  </div>
  % endfor
</div>

<div id="dialog" title="${c.deck.name}">
    <p id="card-description">Question:</p>

    % if c.reverse:
        <p id="card-term">${c.cards[0].definition}</p>
        <p id="card-def">${c.cards[0].term}</p>
    % else:
        <p id="card-term">${c.cards[0].term}</p>
        <p id="card-def">${c.cards[0].definition}</p>
    % endif         
</div>


<%def name="extra_head()">
  <script type="text/javascript" src="/jquery.min.js"></script>
  <script type="text/javascript" src="/jquery-ui.min.js"></script>
  <link type="text/css" href="/ui.all.css" rel="stylesheet" />
</%def>