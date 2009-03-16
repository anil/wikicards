<?xml version="1.0" encoding="UTF-8"?>
<deck>
% for card in c.cards:
  <card>
      <term>
          ${card.term}
      </term>
      <definition>
          ${card.definition}
      </definition>
  </card>
% endfor
</deck>
