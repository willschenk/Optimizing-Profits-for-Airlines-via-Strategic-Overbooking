function figHandle = plotPassengerArrivalSimulation(S, p, numSimulations)
    % Monte Carlo Simulation to Estimate Number of Passengers Arriving
    % Inputs:
    % S - Total number of possible passengers
    % p - Probability of each passenger arriving
    % numSimulations - Number of simulations to run 

    % Allocate array for the number of passengers arriving
    numPassengersArriving = zeros(numSimulations, 1);

    rng(0);

    % Run simulations
    for i = 1:numSimulations
        % Generate random number of passengers based on binomial distribution
        numPassengersArriving(i) = binornd(S, p);
    end

    averageArrivals = mean(numPassengersArriving);
    stdDevArrivals = std(numPassengersArriving);

    figHandle = figure('Visible', 'off', 'Position', [100, 100, 800, 600]);
    set(figHandle, 'PaperUnits', 'inches', 'PaperPosition', [0 0 12 9]);
    histogram(numPassengersArriving, 'Normalization', 'probability', 'FaceColor', '#0072BD', 'FaceAlpha', 0.7);
    xlabel('Number of Passengers Arriving', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Frequency', 'FontSize', 14, 'FontWeight', 'bold');
    title(sprintf('Passenger Arrival Distribution (S = %d, p = %.2f)', S, p), 'FontSize', 16, 'FontWeight', 'bold');
    hold on;
    plot([averageArrivals averageArrivals], ylim, 'r--', 'LineWidth', 2.5);
    legend('Arrival Distribution', sprintf('Average Arrivals: %.2f', averageArrivals), 'FontSize', 14);

    fprintf('Average number of passengers arriving: %.2f\n', averageArrivals);
    fprintf('Standard deviation of arrivals: %.2f\n', stdDevArrivals); 

    set(gcf, 'Color', 'w'); 
    set(figHandle, 'Color', 'w'); 
    hold off; 
end
