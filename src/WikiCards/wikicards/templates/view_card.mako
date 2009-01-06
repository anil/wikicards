<%inherit file="/base.mako" />
  <table border="1">
  <tr>
    <td class="revision heading">Revision</td>
    <td class="term heading">Term</td>
    <td class="definition heading">Definition</td>
    <td class="admin heading">Admin</td>
  % for card in c.cards:
    <tr>
      <td class="revision">Current</td>
      <td class="term">${card.term}</td>
      <td class="definition">${card.definition}</td>
      <td class="admin">
          Revert
       </td>
    </tr>
  % endfor
</table>