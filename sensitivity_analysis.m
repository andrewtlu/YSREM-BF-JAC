% Get sensitivity analysis of r0 values

loadvals

phisubs = 1;
omegaesubs = 90;
omegapsubs = 900;

%% Sensitivity Analysis for R0 Remus

r0_remus

candid1 = subs(r0remus, paramarr, subsarr);

r0remussens = sym(zeros(2, length(paramarr)));

for i = 1:length(paramarr)
    % Label sensitivity
    r0remussens(1, i) = paramarr(i);
    % Get sensitivity
    r0remussens(2, i) = subsarr(i)/candid1*diff(r0remus, paramarr(i));
end

%% Sensitivity Analysis for R0 Intricatoria

r0_intricatoria

candid2 = subs(paramarr, subsarr);

r0intricatoriasens = sym(zeros(2, length(paramarr)));

for i = 1:length(paramarr)
    % Label sensitivity
    r0intricatoriasens(1, i) = paramarr(i);
    % Get sensitivity
    r0intricatoriasens(2, i) = subsarr(i)/candid2*diff(r0intricatoria, paramarr(i));
end

%% Playing around
sigfigs = digits(5);


% Get a numerical representation of row 2
expandedremussens = double(subs(r0remussens(2,:), [paramarr [phi omegae omegap]], [subsarr [phisubs omegaesubs omegapsubs]]));
expandedintricatoriasens = double(subs(r0intricatoriasens(2,:), [paramarr [phi omegae omegap]], [subsarr [phisubs omegaesubs omegapsubs]]));

% Append numerical representations to matrices
r0remussens = [r0remussens; sym(expandedremussens, 'd')];
r0intricatoriasens = [r0intricatoriasens; sym(expandedintricatoriasens, 'd')];

% What we're actually interested in
read_r0remussens = r0remussens;
read_r0remussens(2,:) = []
read_r0intricatoriasens = r0intricatoriasens;
read_r0intricatoriasens(2,:) = []