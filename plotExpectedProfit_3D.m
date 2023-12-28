function figHandle = plotExpectedProfit_3D(N, T, R_0, Delta_R, P_R, lambda, shift, S_range, p_range) 
    % Create a 3D plot of expected profits over varying numbers of tickets sold and passenger arrival probabilities.
    % This function visualizes the expected profit as a function of both the number of tickets sold (S) 
    % and the probability of passengers arriving (p).

    % Initialize matrices for S, p, and profits
    [S_grid, p_grid] = meshgrid(S_range, p_range);
    profits = zeros(size(S_grid));

    % Calculate profits for each (S, p) pair
    for i = 1:numel(S_grid)
        profits(i) = expectedProfit(N, S_grid(i), T, p_grid(i), R_0, Delta_R, P_R, lambda, shift); 
    end

    % Set non-positive profits to 0 for better visualization
    profits(profits <= 0) = 0;

    % Plot
    figHandle = figure('Visible', 'off', 'Position', [100, 100, 800, 600]); 
    set(figHandle, 'PaperUnits', 'inches', 'PaperPosition', [0 0 12 9]);

    surf_handle = surf(S_grid, p_grid, profits);
    xlabel('Number of Tickets Sold (S)', 'FontSize', 12);
    ylabel('Probability of Passengers Arriving (p)', 'FontSize', 12);
    zlabel('Expected Profit ($)', 'FontSize', 12);
    title('3D Plot of Expected Profit', 'FontSize', 14);
    colorbar; % Adds a color bar to indicate profit values
    
    % Set axes to not use scientific notation and adjust font size for clarity
    ax = gca;
    ax.XAxis.Exponent = 0;
    ax.YAxis.Exponent = 0;
    ax.ZAxis.Exponent = 0;
    ax.FontSize = 12;
end
