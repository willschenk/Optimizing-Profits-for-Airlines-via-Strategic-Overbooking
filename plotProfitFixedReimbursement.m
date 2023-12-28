function figHandle = plotProfitFixedReimbursement(N, T, p, R_values, S_range) 
    % Plot the expected profit for different reimbursement values and tickets sold.
    % This function analyzes how the profit changes with varying reimbursements and 
    % number of tickets sold, given a fixed number of seats, ticket price, and 
    % probability of a passenger showing up.

    % Initialize the profits array for varying R and S
    profits = zeros(length(R_values), length(S_range));
    
    % Calculate expected profit for each combination of R and S
    for i = 1:length(R_values)
        R = R_values(i);
        for j = 1:length(S_range)
            S = S_range(j);
            expected_show = S * p;
            overbooked = max(expected_show - N, 0);
            profits(i, j) = S * T - overbooked * R;
        end 
    end 
    
    % Plot 
    figHandle = figure('Visible', 'off', 'Position', [100, 100, 800, 600]); 
    set(figHandle, 'PaperUnits', 'inches', 'PaperPosition', [0 0 12 9]);
    hold on; 
    colors = lines(length(R_values));
    for i = 1:length(R_values)
        plot(S_range, profits(i, :), 'o-', 'Color', colors(i, :), 'LineWidth', 2, 'MarkerEdgeColor', colors(i, :), 'MarkerFaceColor', 'none', 'MarkerSize', 5, 'DisplayName', sprintf('R = $%d', R_values(i))); 
    end 
    hold off; 
    
    xlabel('Number of Tickets Sold (S)', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Expected Profit', 'FontSize', 14, 'FontWeight', 'bold');
    
    titleStr = sprintf('Expected Profit for Varying Reimbursements\nN = %d seats, T = $%d ticket price, p = %.2f probability of showing up', N, T, p);
    title(titleStr, 'FontSize', 16, 'FontWeight', 'bold');
    
    legend('show', 'Location', 'best', 'FontSize', 14);
    grid on;
    
    ax = gca;
    ax.XAxis.Exponent = 0;
    ax.YAxis.Exponent = 0;
    ax.FontSize = 14;

    set(gcf, 'Color', 'w'); 
    set(figHandle, 'Color', 'w'); 

end
