% Get sensitivity analysis of r0 values

loadvals

phival = 100;
omegaeval = 100;
omegapval = 100;

% Include phi, omegae, omegap
paramarr1 = [paramarr [phi omegae omegap]];

subsarr1 = [subsarr [phival omegaeval omegapval]];


%% Sensitivity Analysis for R0 Remus

r0_remus

candid1 = subs(r0remus, paramarr1, subsarr1);

r0remussens = sym(zeros(2, length(paramarr1)));

for i = 1:length(paramarr1)
    % Label sensitivity
    r0remussens(1, i) = paramarr1(i);
    % Get sensitivity
    r0remussens(2, i) = subsarr1(i)/candid1*diff(r0remus, paramarr1(i));
end

%% Sensitivity Analysis for R0 Intricatoria

r0_intricatoria

candid2 = subs(r0intricatoria, paramarr1, subsarr1);

r0intricatoriasens = sym(zeros(2, length(paramarr1)));

for i = 1:length(paramarr1)
    % Label sensitivity
    r0intricatoriasens(1, i) = paramarr1(i);
    % Get sensitivity
    r0intricatoriasens(2, i) = subsarr1(i)/candid2*diff(r0intricatoria, paramarr1(i));
end

%% Playing around
sigfigs = digits(5);


% Get a numerical representation of row 2
expandedremussens = double(subs(r0remussens(2,:), paramarr1, subsarr1));
expandedintricatoriasens = double(subs(r0intricatoriasens(2,:), paramarr1, subsarr1));

% Append numerical representations to matrices
r0remussens = [r0remussens; sym(expandedremussens, 'd')];
r0intricatoriasens = [r0intricatoriasens; sym(expandedintricatoriasens, 'd')];

% What we're actually interested in
read_r0remussens = r0remussens;
read_r0remussens(2,:) = []
read_r0intricatoriasens = r0intricatoriasens;
read_r0intricatoriasens(2,:) = []
%}
