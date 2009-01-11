<%inherit file="/base.mako" />
Are you sure that you want to revert the card
with values:

  <table border="1">
   <tr>
    <td>Term:</td>
    <td>Definition:</td>
   </tr>
   <tr>
    <td>
    ${c.current_card.term}
    </td>
    <td>
     ${c.current_card.definition}
    </td>
   </tr>
  </table>

To:

<table border="1">
 <tr>
  <td>Term:</td>
  <td>Definition:</td>
 </tr>
 <tr>
  <td>
  ${c.old_card.term}
  </td>
  <td>
   ${c.old_card.definition}
  </td>
 </tr>
</table>

<form action ="${h.url_for(controller="Card", action="revert")}" method="POST">
  <input type="submit" value="Confirm" />
  <input type="hidden" name="card_id" value="${c.old_card.id_base30}" />
  <input type="hidden" name="term" value="${c.old_card.term}" />
  <input type="hidden" name="definition" value="${c.old_card.definition}">
  % if c.deck_id != None:
  <input type="hidden" name="deck_id" value="${c.deck_id}">
  % endif
  
</form>
 
   