% Get 3D r0 graphs with respect to phi and either omegae or omegap

%% Graph remus
r0_remus

r0remus = subs(r0remus, paramarr, subsarr);

syms x y
r0remus = subs(r0remus, [phi omegae], [x y]);

figure
colormap winter;
phimax = 500;
omegaemax = 225000;

fsurf(r0remus, [0 phimax 0 omegaemax])

xlabel('\Phi', 'fontsize', 16)
ylabel('\omega_E', 'fontsize', 16)
zlabel('ℛ_{0}^R', 'fontsize', 16)
view([-1 2 1])

%% Graph intricatoria
r0_intricatoria

r0intricatoria = subs(r0intricatoria, paramarr, subsarr);

syms x y
r0intricatoria = subs(r0intricatoria, [phi omegap], [x y]);

figure
colormap autumn;
phimax = 500;
omegapmax = 2500;

fsurf(r0intricatoria, [0 phimax 0 omegapmax])

xlabel('\Phi', 'fontsize', 16)
ylabel('\omega_P', 'fontsize', 16)
zlabel('ℛ_{0}^R', 'fontsize', 16)
view([-1 2 1])
