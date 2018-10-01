var VIP >= 0, integer;
var GRAL >= 0, integer;
var PAQ >= 0, integer;
var PAQVIP >= 0, integer;
var PAQGRAL >= 0, integer;

maximize z: 1500*(VIP - 100) + 800*GRAL - 700*PAQ;

s.t. procEq1: 1*VIP + 0.5*GRAL <= 8000;
s.t. procEq2: VIP >= 100;
s.t. procEq3: GRAL >= 500;
s.t. procEq4: PAQ - PAQVIP - PAQGRAL = 0;
s.t. procEq5: (1/8)*GRAL - PAQGRAL = 0;
s.t. procEq6: (1/20)*VIP - PAQVIP = 0;
s.t. procEq7: PAQ <= 800;


end;
