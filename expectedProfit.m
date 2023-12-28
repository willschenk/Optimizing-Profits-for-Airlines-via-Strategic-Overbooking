function profitExpected = expectedProfit(N, S, T, p, R_0, deltaR, P_R, lambda, shift) 
    % Calculate the expected profit. All overbooked passengers will receive
    % the same reparation R after the bidding is complete. 

    % Initialize loss
    Loss = 0; 

    % Calculate loss if overbooking occurs (when sold tickets exceed available seats)
    if N < S 
        for j = N+1:S % Iterate over each possible number of overbooked and arriving passengers
            % Add the loss due to each overbooking scenario 
                % This is the outer sum from x = N + 1 to S 
                % binopdf is the binomial pdf P_x(x) and is the liklihood of x (here j)
                % passengers out of S, accepting something of probability
                % p. 
                % Then multiply this by the Expected Loss funciton 
            Loss = Loss + binopdf(j, S, p) * expectedLoss(j, N, P_R, lambda, shift, R_0, deltaR, T, 6);
        end
    end

    % Calculate expected profit 
    profitExpected = S * T - Loss; 
end 
