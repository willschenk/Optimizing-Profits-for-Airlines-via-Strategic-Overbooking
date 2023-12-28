%% Initialization
% Set up the basic parameters for the airline overbooking model.
N = 200;        % Number of seats 
T = 300;        % Ticket price 
p = 0.95;       % Probability of a passenger showing up 
R_0 = T + 100;  % Base reimbursement amount
Delta_R = 100;  % Increase in reimbursement each round 
lambda = 0.01;  % Parameter for reimbursement acceptance probability 
shift = 2;      % Horizontal shift for the reimbursement acceptance probability 
max_overbooking_factor = 0.25; % Maximum overbooking percentage 

% Validate input parameters to ensure they are valid.
assert(N > 0, 'Error: Number of seats (N) must be positive');
assert(T > 0, 'Error: Ticket price (T) must be positive');
assert(p >= 0 && p <= 1, 'Error: Probability (p) must be in the range [0, 1]');
assert(Delta_R >= 0, 'Error: Reimbursement increment (Delta_R) must be non-negative');
assert(max_overbooking_factor >= 0, 'Error: Overbooking factor must be greater than or equal to zero');
assert(lambda >= 0 && lambda <= 10, 'Error: Lambda (lambda) must be in the range [0, 10]'); 

%% Define Probability of Accepting a Reimbursement 
% Define a function to calculate the probability of accepting a reimbursement.
P_R = @(R, lambda, shift, T) (1 + tanh(lambda * (R - shift * T))) / 2;

% Plot the reimbursement acceptance probability for visual analysis.
acceptancePlot = run_with_ConsoleLog(@plotReimbursementAcceptance, P_R, R_0, lambda, shift, T); 
figure(acceptancePlot) 

%% Define Probability of Accepting a Reimbursement (Test out various lambda)
% Test and plot reimbursement acceptance probability with varied lambda values.
acceptancePlot_Varied_Parameters = run_with_ConsoleLog(@plotReimbursementAcceptance_Vary_Lambda, P_R, R_0, T, [0.005, 0.01, 0.02, 0.04], [2, 2, 2, 2]); 
figure(acceptancePlot_Varied_Parameters) 

%% Define Ranges for Analysis 
% Define the range of tickets to sell for analysis.
S_min = N; % Minimum number of tickets to sell 
S_max = N + round(N * max_overbooking_factor); % Maximum number of tickets to sell 
S_range = S_min:S_max; % Range of tickets to sell

%% Expected Profit using Fixed Reimbursement for Overbooked Passengers (S is varied)
% Plot expected profit using fixed reimbursement for varying numbers of tickets sold.
Fixed_Reimbursement_Plot = run_with_ConsoleLog(@plotProfitFixedReimbursement, N, T, p, linspace(R_0, R_0 + Delta_R * 4, 5), S_range);
figure(Fixed_Reimbursement_Plot) 

%% Expected Profit using Variable Reimbursements Based on Acceptance Probability (S is varied) 
% Plot expected profit using variable reimbursements based on acceptance probability.
[Expected_Profits_Plot_S, S_optimal] = run_with_ConsoleLog(@plotExpectedProfits_S, N, T, p, R_0, Delta_R, P_R, lambda, shift, max_overbooking_factor);
figure(Expected_Profits_Plot_S) 

%% Expected Profit using Variable Reimbursements (p is Varied) 
% Plot expected profit for varying passenger show-up probabilities.
Expected_Profits_Plot_p = run_with_ConsoleLog(@plotExpectedProfit_p, N, S_optimal, T, R_0, Delta_R, P_R, lambda, shift);
figure(Expected_Profits_Plot_p) 

%% Monte Carlo Simulation: Passenger Arrival
% Perform and plot a Monte Carlo simulation for passenger arrival.
Monte_Carlo_passenger_Plot = run_with_ConsoleLog(@plotPassengerArrivalSimulation, S_optimal, p, 10000); 
figure(Monte_Carlo_passenger_Plot) 

%% Monte Carlo Simulation: Expected Profit for varying number of tickets S sold 
% Perform and plot Monte Carlo simulations for expected profit with varying number of tickets sold.
Monte_Carlo_Expected_Profit_Plot_Optimal_Tickets = run_with_ConsoleLog(@plotExpectedProfitSimulation, N, S_optimal, T, p, R_0, Delta_R, P_R, lambda, shift, 500); 
figure(Monte_Carlo_Expected_Profit_Plot_Optimal_Tickets);

% Additional simulations for specific numbers of tickets sold.
Monte_Carlo_Expected_Profit_Plot_210_Tickets = run_with_ConsoleLog(@plotExpectedProfitSimulation, N, 210, T, p, R_0, Delta_R, P_R, lambda, shift, 500);
figure(Monte_Carlo_Expected_Profit_Plot_210_Tickets);

Monte_Carlo_Expected_Profit_Plot_215_Tickets = run_with_ConsoleLog(@plotExpectedProfitSimulation, N, 215, T, p, R_0, Delta_R, P_R, lambda, shift, 500);
figure(Monte_Carlo_Expected_Profit_Plot_215_Tickets);

Monte_Carlo_Expected_Profit_Plot_220_Tickets = run_with_ConsoleLog(@plotExpectedProfitSimulation, N, 220, T, p, R_0, Delta_R, P_R, lambda, shift, 500); 
figure(Monte_Carlo_Expected_Profit_Plot_220_Tickets);

Monte_Carlo_Expected_Profit_Plot_240_Tickets = run_with_ConsoleLog(@plotExpectedProfitSimulation, N, 240, T, p, R_0, Delta_R, P_R, lambda, shift, 500);
figure(Monte_Carlo_Expected_Profit_Plot_240_Tickets);

%% Save All Figures in High Quality
% Save all generated figures in high-quality format.
saveFigureHighQuality(acceptancePlot_Varied_Parameters); 
saveFigureHighQuality(acceptancePlot);
saveFigureHighQuality(Monte_Carlo_passenger_Plot);
saveFigureHighQuality(Fixed_Reimbursement_Plot);
saveFigureHighQuality(Expected_Profits_Plot_S); 
saveFigureHighQuality(Expected_Profits_Plot_p); 
saveFigureHighQuality(Monte_Carlo_Expected_Profit_Plot_Optimal_Tickets); 
saveFigureHighQuality(Monte_Carlo_Expected_Profit_Plot_210_Tickets); 
saveFigureHighQuality(Monte_Carlo_Expected_Profit_Plot_215_Tickets); 
saveFigureHighQuality(Monte_Carlo_Expected_Profit_Plot_220_Tickets); 
saveFigureHighQuality(Monte_Carlo_Expected_Profit_Plot_240_Tickets); 
