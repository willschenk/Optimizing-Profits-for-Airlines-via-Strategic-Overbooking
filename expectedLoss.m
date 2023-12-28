function EL = expectedLoss(j, N, P_R, lambda, shift, R_0, deltaR, T, level)
% Calculate the expected loss due to overbooking. 

% Inputs: 
%   j       - Number of overbooked passengers
%   N       - Number of available seats
%   P_R     - Probability function for the likelihood of any passenger
%             accepting reimbursement R
%   lambda  - Parameter for the P_R function
%   shift   - Horizontal shift parameter for the P_R function
%   R_0     - Initial reimbursement amount
%   deltaR  - Increment in reimbursement amount each round
%   T       - Ticket price
%   level   - Recursive level for the loss calculation
% 
% Output: 
%   EL      - Expected loss due to overbooking j passengers 

    % Calculate the expected loss using the recursive loss function
    EL = (j - N) * recursiveLoss(P_R, lambda, shift, R_0, deltaR, T, level);
end