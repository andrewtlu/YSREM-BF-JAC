% Relate r0 to population dynamics according to model
% Save commented out by default, go to section at end of code to re-enable

clearvars
dfe_subs

%% Variables/Graphing Parameters

% Timeline/Graph/Initial
% Increment desired variable in for loop
phival = 75;
omegaeval = 400000;
omegapval = 200;
stepsize = 200;
steps = 39;
markercount = 10;
maxtime = 730;
ylim1 = 12000;
ylim2 = 220;
initialBE = double(subs(BE0, [phi omegae omegap], [phival omegaeval omegapval]));
initialBL = double(subs(BL0, [phi omegae omegap], [phival omegaeval omegapval]));
initialBP = double(subs(BP0, [phi omegae omegap], [phival omegaeval omegapval]));
initialBA = double(subs(BA0, [phi omegae omegap], [phival omegaeval omegapval]));
initialRE = 0;
initialRA = 0;
initialIE = 0;
initialIA = 9000;

% Known
Lambda = 265.45;
gamma1 = 1/6; 
delta = 125/78302;
gamma2 = 2/15;
beta1 = 574/9;
beta2 = 5;
epsilon1 = 0.0429;
epsilon2 = .883/28;
mube = 1165/18702;
mubl = 1935/39151;
mubp = 32/315;
muba = 2/47;
mure = 0.0776;
mura = 1/9;
muie = .117/28;
muia = 1/27;
thetab = 0.5;
thetar = 0.72;
thetai = 0.5;

%% Diff eqs
% y(
% 1 - BE, 2 - BL, 3 - BP, 4 - BA
% 5 - RE, 6 - RA, 7 - IE, 8 - IA
% )
f = @(t, y)[
    Lambda*y(4)*thetab*(1-(y(1)+y(2)+y(5))/(180*y(9))) - beta1*1/(y(1)+y(10))*(y(1)/(y(1)+y(5)))*y(6)*thetar*y(1) - y(1)*(1-beta1*1/(y(1)+y(10))*(y(1)/(y(1)+y(5))))*gamma1 - mube*y(1), 
    (1-beta1*1/(y(1)+y(10))*(y(1)/(y(1)+y(5))))*y(1)*gamma1 - delta*y(2) - mubl*y(2), 
    delta*y(2) - beta2*1/(y(3)+y(11))*(y(3)/(y(7)+y(3)))*y(8)*thetai*y(3) - (1-beta2*1/(y(3)+y(11))*(y(3)/(y(7)+y(3)))*y(8)*thetai)*y(3)*gamma2 - mubp*y(3), 
    (1-beta2*(1/(y(3)+y(11)))*(y(3)/(y(7)+y(3)))*y(8)*thetai)*y(3)*gamma2 - muba*y(4), 
    beta1*1/(y(1)+y(10))*(y(1)/(y(1)+y(5)))*y(6)*thetar*y(1) - epsilon1*y(5) - mure*y(5), 
    epsilon1*y(5) - mura*y(6),
    beta2*1/(y(3)+y(11))*(y(3)/(y(7)+y(3)))*y(8)*thetai*y(3) - epsilon2*y(7) - muie*y(7),
    epsilon2*y(7) - muia*y(8)
    0, % change in Phi
    0, % change in omegae
    0, % change in omegap
    ];

%% Threshold

r0_intricatoria

% Calculate threshold
intricatoriathreshold = solve(r0intricatoria == 1, phi);

intricatoriathreshold = subs(intricatoriathreshold, paramarr, subsarr);

% Simplify r0
r0intricatoria = subs(r0intricatoria, paramarr, subsarr);

%% Reset BE0, BL0, BP0, and BA0 to be in terms of Phi, omegae, omegap

dfe_subs

%% Rendering

for i = 1:steps
    [t, ya] = ode45(f, [0 maxtime], [initialBE, initialBL, initialBP, initialBA, initialRE, initialRA, initialIE, initialIA, phival, omegaeval, omegapval]);
    
    % Graph
    figure
    hold on
    
    xlim([0, maxtime])
    ylim([0, ylim1])
    
    % All
    plot(t, ya(:, 3) + ya(:, 7), '--',...
        'Color', 'black',...
        'LineWidth', 1) % Total Pupa
    plot(t, ya(:, 1), ':',...
        'Color', 'blue',...
        'LineWidth', 1,...
        'Marker', 'o',...
        'MarkerSize', 6,...
        'MarkerIndices', round(length(ya(:, 1))/markercount):round(length(ya(:, 1))/markercount):length(ya(:, 1))) % BE
    plot(t, ya(:, 2), '-.ro',... 
        'LineWidth', 1,...
        'MarkerSize', 6,...
        'MarkerIndices', round(length(ya(:, 1))/markercount):round(length(ya(:, 2))/markercount):length(ya(:, 2))) % BL
    plot(t, ya(:, 3), '--',...
        'Color', [1, 0.5, 0],...
        'LineWidth', 1,...
        'Marker', 'o',...
        'MarkerSize', 6,...
        'MarkerIndices', round(length(ya(:, 1))/markercount):round(length(ya(:, 3))/markercount):length(ya(:, 3))) % BP
    plot(t, ya(:, 4), '-',...
        'Color', [0.5, 0, 0.5],...
        'LineWidth', 1,...
        'Marker', 'o',...
        'MarkerSize', 6,...
        'MarkerIndices', round(length(ya(:, 1))/markercount):round(length(ya(:, 4))/markercount):length(ya(:, 4))) % BA
    plot(t, ya(:, 7), '--m',...
        'LineWidth', 1,...
        'Marker', '+',...
        'MarkerSize', 6,...
        'MarkerIndices', round(length(ya(:, 1))/markercount):round(length(ya(:, 7))/markercount):length(ya(:, 7))) % IE
    plot(t, ya(:, 8), '-',...
        'Color', [0.7, 0, 0.2],...
        'LineWidth', 1,...
        'Marker', '+',...
        'MarkerSize', 6,...
        'MarkerIndices', round(length(ya(:, 1))/markercount):round(length(ya(:, 8))/markercount):length(ya(:, 8))) %IA
    legend('B_P + I_E', 'B_E', 'B_L', 'B_P', 'B_A', 'I_E', 'I_A', 'FontSize', 12)
    xlabel('Time (Days)')
    ylabel('Amount')
    
    % Strict only
    fs = figure;
    fs.Position(4) = 300;
    hold on

    xlim([0, maxtime])
    ylim([0, ylim2])
    
    plot(t, ya(:, 3) + ya(:, 7), '--',...
        'Color', 'black',...
        'LineWidth', 1) % Total Pupa
    plot(t, ya(:, 3), '--',...
        'Color', [1, 0.5, 0],...
        'LineWidth', 1,...
        'Marker', 'o',...
        'MarkerSize', 6,...
        'MarkerIndices', round(length(ya(:, 1))/markercount):round(length(ya(:, 3))/markercount):length(ya(:, 3))) % BP
    plot(t, ya(:, 4), '-',...
        'Color', [0.5, 0, 0.5],...
        'LineWidth', 1,...
        'Marker', 'o',...
        'MarkerSize', 6,...
        'MarkerIndices', round(length(ya(:, 1))/markercount):round(length(ya(:, 4))/markercount):length(ya(:, 4))) % BA
    plot(t, ya(:, 7), '--m',...
        'LineWidth', 1,...
        'Marker', '+',...
        'MarkerSize', 6,...
        'MarkerIndices', round(length(ya(:, 1))/markercount):round(length(ya(:, 7))/markercount):length(ya(:, 7))) % IE
    plot(t, ya(:, 8), '-',...
        'Color', [0.7, 0, 0.2],...
        'LineWidth', 1,...
        'Marker', '+',...
        'MarkerSize', 6,...
        'MarkerIndices', round(length(ya(:, 1))/markercount):round(length(ya(:, 8))/markercount):length(ya(:, 8))) %IA
    legend('B_P + I_E', 'B_P', 'B_A', 'I_E', 'I_A', 'FontSize', 12)
    xlabel('Time (Days)')
    ylabel('Amount')
    
    % Threshold
    figure
    hold on;
    omegapmax = 8000;
    xlim([0 omegapmax])
    ylim([0, 150])
    
    fplot(intricatoriathreshold, [0 omegapmax],...
        'LineStyle', '-.',...
        'DisplayName', 'ℛ_{0}^I = 1')
    patch('XData', [0 omegapmax omegapmax],...
        'YData', [0 0 double(subs(intricatoriathreshold, omegap, omegapmax))],...
        'FaceColor', [0 .5 1],...
        'EdgeColor', 'none',...
        'FaceAlpha', 0.25,...
        'DisplayName', 'ℛ_{0}^I < 1')
    
    plot(omegapval, phival, 'r.',...
        'MarkerFaceColor', 'red',...
        'MarkerSize', 10,...
        'DisplayName', '\omega_P, \Phi')
    text(400, 120, strcat('(\omega_P: ', sprintf('%.0f', omegapval), ', \Phi: ', sprintf('%.0f', phival), ')'),...
        'Color', 'black', 'FontSize', 16)
    text(400, 135, strcat('ℛ_{0}^I: ', sprintf('%.3f', double(subs(r0intricatoria, [phi omegap], [phival, omegapval])))),...
        'Color', 'black', 'FontSize', 16)
    legend('FontSize', 12)
    
    xlabel('\omega_P', 'fontsize', 14)
    ylabel('\Phi', 'fontsize', 14)
    
    % Increment desired variable here:
    omegapval = omegapval + stepsize;

    initialBE = double(subs(BE0, [phi omegae omegap], [phival omegapval omegapval]));
    initialBL = double(subs(BL0, [phi omegae omegap], [phival omegapval omegapval]));
    initialBP = double(subs(BP0, [phi omegae omegap], [phival omegapval omegapval]));
    initialBA = double(subs(BA0, [phi omegae omegap], [phival omegapval omegapval]));
end

%% Save
% Add a single character after the { to re-enable saving figures
%{
dir = 'tempdir';
figlist = flip(findobj(allchild(0), 'flat', 'Type', 'figure')); % All figures, flip since LIFO
for i = 1:length(figlist)
    fighandle = figlist(i);
    
    if mod(i, 3) == 1 % All Graphs
        fn = num2str((i+2)/3);
        saveas(fighandle, fullfile(dir, [strcat('i-all-', fn) '.png']))
    elseif mod(i, 3) == 2 % Just BP, BA, IE, IA
        fn = num2str((i+1)/3);
        saveas(fighandle, fullfile(dir, [strcat('i-strict-', fn) '.png']))
    else
        fn = num2str(i/3);
        saveas(fighandle, fullfile(dir, [strcat('i-thresh-', fn) '.png']))

    end
end
%}
