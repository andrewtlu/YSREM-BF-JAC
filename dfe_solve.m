% Get DFE of butterfly compartments in terms of parameters

loadvals

% Non-infection dif eqs
dBEdt = Lambda*BA*thetab*(1-(BE+BL+RE)/kappael) - tau1*BE - (1 - tau1)*gamma1*BE - mube*BE;
dBLdt = (1 - tau1)*gamma1*BE - delta*BL - mubl*BL;
dBPdt = delta*BL - tau2*BP - (1 - tau2)*gamma2*BP - mubp*BP;
dBAdt = (1 - tau2)*gamma2*BP - muba*BA;

% Solve eqs
BE0 = dBEdt;
BL0 = solve(dBLdt == 0, BL);
BP0 = solve(dBPdt == 0, BP);
BA0 = solve(dBAdt == 0, BA);

% Expand tau1 and tau2
BE0 = subs(BE0, [tau1 tau2], [tau1subs tau2subs]);
BL0 = subs(BL0, [tau1 tau2], [tau1subs tau2subs]);
BP0 = subs(BP0, [tau1 tau2], [tau1subs tau2subs]);
BA0 = subs(BA0, [tau1 tau2], [tau1subs tau2subs]);

% Put BP0, BA0 in terms of BE
BP0 = subs(BP0, BL, BL0);
BA0 = subs(BA0, BP, BP0);

% DFE -> RE, RA, IE, IA = 0
BE0 = subs(BE0, [RE RA IE IA], [0 0 0 0]);
BL0 = subs(BL0, [RE RA IE IA], [0 0 0 0]);
BP0 = subs(BP0, [RE RA IE IA], [0 0 0 0]);
BA0 = subs(BA0, [RE RA IE IA], [0 0 0 0]);

BE0 = subs(BE0, [BL BP BA], [BL0 BP0 BA0]);
BE0 = solve(BE0 == 0, BE);

% Put in terms of phi
BE0 = BE0(2);
BL0 = subs(BL0, BE, BE0);
BP0 = subs(BP0, BE, BE0);
BA0 = subs(BA0, BE, BE0);
