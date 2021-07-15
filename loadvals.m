% Load syms variables, paramarrs, and subsarr

syms BE BL BP BA RE RA IE IA phi Lambda ...
    gamma1 delta gamma2 beta1 beta2     ...
    epsilon1 epsilon2 mube mubl mubp    ...
    muba mure mura muie muia thetab     ...
    thetar thetai omegae omegap tau1 tau2

kappael = 180 * phi;
Lambdasubs = 265.45;
gamma1subs = 1/6; 
deltasubs = 125/78302;
gamma2subs = 2/15;
beta1subs = 574/9;
beta2subs = 5;
epsilon1subs = 0.0429;
epsilon2subs = .883/28;
mubesubs = 1165/18702;
mublsubs = 1935/39151;
mubpsubs = 32/315;
mubasubs = 2/47;
muresubs = 0.0776;
murasubs = 1/9;
muiesubs = .117/28;
muiasubs = 1/27;
thetabsubs = 0.5;
thetarsubs = 0.72;
thetaisubs = 0.5;
tau1subs = beta1*RA*thetar*1/(BE+omegae)*(1-RE/(BE+RE));
tau2subs = beta2*IA*thetai*1/(BP+omegap)*(1-IE/(BP+IE));

paramarr = [Lambda gamma1 delta gamma2  ...
    beta1 beta2 epsilon1 epsilon2 mube  ...
    mubl mubp muba mure mura muie muia  ...
    thetab thetar thetai];

subsarr = [Lambdasubs gamma1subs deltasubs gamma2subs              ...
    beta1subs beta2subs epsilon1subs epsilon2subs mubesubs         ...
    mublsubs mubpsubs mubasubs muresubs murasubs muiesubs muiasubs ...
    thetabsubs thetarsubs thetaisubs];