function loss = recursiveLoss(P_R, lambda, shift, R_0, deltaR, T, level)
    if level < 0 % Note: We start the recursion at level zero. 
        loss = 0; % Base case 
    else
        % Calculate the probability of a passenger accepting the current reimbursement offer
        P_R_current = P_R(R_0 + level * deltaR, lambda, shift, T);
        
        % Calculate the cumulative loss up to the previous level
        loss_previous = recursiveLoss(P_R, lambda, shift, R_0, deltaR, T, level - 1);
        
        % Combine the loss at the current level with the loss from the previous level
        loss = (1 - P_R_current) * loss_previous + P_R_current * (R_0 + level * deltaR);
    end
end