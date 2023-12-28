function [figHandle, best_number_of_tickets] = plotExpectedProfits_S(N, T, p, R_0, Delta_R, P_R, lambda, shift, max_overbooking_factor)
    % Plot expected profits versus the number of tickets sold.
    % This function calculates and visualizes the expected profit for a range of tickets sold,
    % based on the airline's overbooking strategy and other parameters like
    % ticket price and no-show probability. 

    max_S = N + round(N * max_overbooking_factor); % Max number of tickets to sell
    S = N:max_S; % Range of tickets to sell 

    % Calculating profits 
    profits = zeros(1, length(S)); 
    for i = 1:length(S) % For each number of tickets sold S, record the expected profit 
        profits(i) = expectedProfit(N, S(i), T, p, R_0, Delta_R, P_R, lambda, shift);
    end 

    % Plot 
    figHandle = figure('Visible', 'off', 'Position', [100, 100, 800, 600]);
    set(figHandle, 'PaperUnits', 'inches', 'PaperPosition', [0 0 12 9]);
    plot(S, profits, 'ko-', 'LineWidth', 2, 'MarkerEdgeColor', 'black', 'MarkerSize', 8, 'MarkerFaceColor', 'none');
    grid on;
    title('Tickets Sold Versus Expected Profit', 'FontSize', 16, 'FontWeight', 'bold');

    xlabel('Number of Tickets Sold', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Expected Profit ($)', 'FontSize', 14, 'FontWeight', 'bold'); 
    
    [max_profit, max_index] = max(profits);
    min_profit = min(profits);
    
    y_range = max_profit - min_profit;
    if y_range > 0
        ylim([min_profit - 0.1 * y_range, max_profit + 0.1 * y_range]);
    else
        ylim([min_profit - 1, max_profit + 1]); 
    end

    hold on;
    max_profit_point = plot(S(max_index), max_profit, 'o', 'MarkerSize', 14, 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'none');
    plot([S(max_index), S(max_index)], [0, max_profit], 'r--', 'LineWidth', 1.5);

    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    ax.Box = 'off';
    ax.XAxis.Exponent = 0;
    ax.YAxis.Exponent = 0;
    ax.FontSize = 14;

    % Best number of tickets S_optimal 
    best_number_of_tickets = round(S(max_index));
    legend_text = sprintf('Max Profit: $%.2f \nTickets to Sell to Maximize Immediate Profits: %d', max_profit, best_number_of_tickets);
    legend(max_profit_point, legend_text, 'Location', 'best', 'FontSize', 14);

    set(gcf, 'Color', 'w'); 
    set(figHandle, 'Color', 'w'); 

end
