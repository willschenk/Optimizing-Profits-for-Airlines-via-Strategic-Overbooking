function figHandle = plotExpectedProfitSimulation(N, S_optimal, T, p, R_0, Delta_R, P_R, lambda, shift, numSimulations)
    % Conduct a Monte Carlo simulation to evaluate the profitability of an airline's overbooking strategy.
    % This function simulates the profit outcomes for an optimal number of tickets sold (S_optimal),
    % considering the dynamics of the overbooking strategy and the
    % passenger no-show probability. 

    noShowRate = 1 - p; % Probability that a passenger who bought a ticket will not show up 
    
    profits = zeros(numSimulations, 1);
    passengersIntendingToBoard = zeros(numSimulations, 1);
    
    rng(0);
    
    % Run Simulations 
    for i = 1:numSimulations
        % Generate a random number of no-shows based on the binomial
        % distribution 
        noShows = binornd(S_optimal, noShowRate);
        
        % Calculate the number of passengers who need reparation 
        passengersNeedingReparation = max(S_optimal - N - noShows, 0);
        
        % Initialize reparation amount
        reparationAmount = R_0; % Start at the base ticket price 
        
        % Calculate the total reparation cost 
        reparationCost = 0;
        for j = 1:passengersNeedingReparation
            while true 
                if rand() < P_R(reparationAmount, lambda, shift, T)
                    reparationCost = reparationCost + reparationAmount;
                    break; % Exit the loop if the reparation is accepted
                else
                    reparationAmount = reparationAmount + Delta_R;
                end
            end
        end
        
        profit = S_optimal * T - reparationCost;
        profits(i) = profit;

        % Record the number of passengers intending to board
        passengersIntendingToBoard(i) = S_optimal - noShows;
    end
    
    % Calculate average profit and average number of passengers intending to board
    averageProfit = mean(profits);
    averagePassengers = mean(passengersIntendingToBoard);

    % Visualization 
    figHandle = figure('Visible', 'off', 'Position', [100, 100, 800, 600]); 
    set(figHandle, 'PaperUnits', 'inches', 'PaperPosition', [0 0 12 9]);
    set(figHandle, 'Color', 'w'); 

    h = histogram(profits, 'Normalization', 'probability');
    h.FaceColor = 'blue';

    ax = gca;
    ax.FontSize = 18; 
    xlabel('Profit ($)', 'FontSize', 18);
    ylabel('Frequency', 'FontSize', 18);
    title('Profit Distribution from Monte Carlo Simulation', 'FontSize', 20);

    ax.XAxis.Exponent = 0;
    ax.YAxis.Exponent = 0;
    ax.Color = 'w'; 
    ax.YGrid = 'on'; % Enable horizontal grid lines
    
    hold on;
    plot([averageProfit averageProfit], ylim, 'r--', 'LineWidth', 2);
    legend('Profit Distribution', sprintf('Average Profit: $%.2f', averageProfit), 'Location', 'best', 'FontSize', 18); 

    text(min(xlim) + 0.05 * range(xlim), max(ylim) * 0.93, ...
     sprintf('Average Profit: $%.2f\nAverage Passengers: %.2f\nS Tickets Sold: %d', averageProfit, averagePassengers, S_optimal), ...
     'FontSize', 18, 'BackgroundColor', 'white', 'EdgeColor', 'black');
    hold off; 
end
