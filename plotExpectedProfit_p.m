function figHandle = plotExpectedProfit_p(N, S, T, R_0, Delta_R, P_R, lambda, shift)
    % Plot the expected profits versus the probability of passengers showing up.
    % This function visualizes how the expected profit varies with the changing probability
    % of passengers showing up, while keeping the number of sold tickets (S) constant.

    % Define the range of probabilities 
    probability_range = 0.1:0.01:0.99; % Adjust as needed

    % Initialize an array to store profits for each probability
    profits_for_probabilities = zeros(size(probability_range));

    % Loop over the probability range
    for i = 1:length(probability_range)
        p_current = probability_range(i);  % Current probability
        profits_for_probabilities(i) = expectedProfit(N, S, T, p_current, R_0, Delta_R, P_R, lambda, shift);
    end 

    % Plotting expected profits vs. probability
    figHandle = figure('Visible', 'off', 'Position', [100, 100, 800, 600]);
    set(figHandle, 'PaperUnits', 'inches', 'PaperPosition', [0 0 12 9]); 
    plot_handle = plot(probability_range, profits_for_probabilities, 'ko-', 'LineWidth', 2, 'MarkerEdgeColor', 'black', 'MarkerSize', 8, 'MarkerFaceColor', 'none');
    xlabel('Probability of Passenger Showing Up', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Expected Profit', 'FontSize', 14, 'FontWeight', 'bold');
    
    title({'Expected Profit vs. Probability of Passenger Showing Up', ...
           sprintf('For optimal S = %d tickets sold out of N = %d seats available', S, N)}, ...
           'FontSize', 16, 'FontWeight', 'bold');
    
    grid on;
    
    legend(plot_handle, sprintf('Profit for S = %d', S), 'Location', 'best', 'FontSize', 14);
    
    ax = gca;
    ax.XAxis.Exponent = 0;
    ax.YAxis.Exponent = 0;
    ax.FontSize = 14; 

    set(ax, 'Color', 'w'); 
    set(figHandle, 'Color', 'w'); 

end
