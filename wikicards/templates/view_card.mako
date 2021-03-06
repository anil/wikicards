<%inherit file="/base.mako" />
  <table border="1">
  <tr>
    <td class="revision heading">Revision</td>
    <td class="term heading">Term</td>
    <td class="definition heading">Definition</td>
    <td class="admin heading">Admin</td>
  % for counter in range(0,c.num_cards):
    <tr>
      <td class="revision">${c.num_cards - counter}</td>
      <td class="term">${c.cards[counter].term}</td>
      <td class="definition">${c.cards[counter].definition}</td>
      <td class="admin">
          % if counter != 0:
            <a href="${h.url_for(controller='Card', action='revert', revision=c.num_cards - counter, referring_deck = c.deck_id)}">Revert</a>
          % endif
       </td>
    </tr>
  % endfor
</table>