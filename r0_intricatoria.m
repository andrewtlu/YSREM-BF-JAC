% Solve for r0 of intricatoria

%% Next Gen
dfe_solve

% scriptF
sF = [
    tau2subs*BP   ,
    0
    ];

F = jacobian(sF, [IE IA]);

F = subs(F, BE, BE0);
F = subs(F, BL, BL0);
F = subs(F, BP, BP0);
F = subs(F, BA, BA0);
F = subs(F, RE, 0);
F = subs(F, RA, 0);
F = subs(F, IE, 0);
F = subs(F, IA, 0);

% scriptV
sV = [
    epsilon2*IE + muie*IE   ,
    -epsilon2*IE + muia*IA
    ];

V = jacobian(sV, [IE IA]);

V = subs(V, BE, BE0);
V = subs(V, BL, BL0);
V = subs(V, BP, BP0);
V = subs(V, BA, BA0);
V = subs(V, RE, 0);
V = subs(V, RA, 0);
V = subs(V, IE, 0);
V = subs(V, IA, 0);

% Find F * V^{-1}
FVinv = F/V;
  
% Find the eigenvalues
eigen = eig(FVinv);

r0intricatoria = eigen(2);
