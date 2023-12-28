% This is used for the P_R plot in the paper 

P_R = @(R, lambda, T) (1 + tanh(lambda * (R - 2 * T))) / 2;

R = linspace(0, 1500, 300); 

T = 500; 
lambdas = [0.005, 0.0025, 0.00125];

figure;

hold on; 
for i = 1:length(lambdas)
    plot(R, P_R(R, lambdas(i), T), 'LineWidth', 1.5); 
end
hold off;

legend(arrayfun(@(x) ['\lambda = ' num2str(x)], lambdas, 'UniformOutput', false), 'Location', 'Southeast');

xlabel('Reparation Amount R', 'FontSize', 14);
ylabel('Probability of Accepting Reparation P(R)', 'FontSize', 14);
title('Probability of Passenger Acceptance for Varying Reparation Amounts', 'FontSize', 16);

xlim([0, 1500]);
ylim([0, 1.1]); 

grid on;

%% 

P_R = @(R, lambda, R_high) min((R/R_high).^lambda, 1);

R = linspace(0, 1500, 300); 

R_high = 1500; 

lambdas = [0.1, 0.5, 1, 5, 10];

figure;

hold on; 
for i = 1:length(lambdas)
    plot(R, P_R(R, lambdas(i), R_high), 'LineWidth', 1.5); 
end
hold off;

legend(arrayfun(@(x) ['\lambda = ' num2str(x)], lambdas, 'UniformOutput', false), 'Location', 'Southeast');

xlabel('Reparation Amount R', 'FontSize', 14);
ylabel('Probability of Accepting Reparation P(R)', 'FontSize', 14);
title('Probability of Passenger Acceptance for Varying Reparation Amounts', 'FontSize', 16);

xlim([0, 1500]);
ylim([0, 1.1]); 

set(gca, 'FontSize', 12);

grid on; 

