function figHandle = plotReimbursementAcceptance_Vary_Lambda(P_R, R_0, T, lambda_values, shift_values)

    % Validate the input arrays for lambda and shift
    if length(lambda_values) ~= 4 || length(shift_values) ~= 4
        error('Lambda and Shift arrays must each have 4 elements.');
    end

    % Generate a range of reimbursement amounts for plotting
    R_min = 0;
    R_max = R_0 * 3;
    R_values = linspace(R_min, R_max, 200);

    figHandle = figure('Visible', 'off');
    hold on; 

    for i = 1:4
        lambda = lambda_values(i);
        shift = shift_values(i);
        acceptance_probs = arrayfun(@(R) P_R(R, lambda, shift, T), R_values); 

        plot(R_values, acceptance_probs, 'LineWidth', 2); % Plot with unique color automatically
    end

    % Set labels and title
    xlabel('Reimbursement Amount ($)', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Likelihood of Acceptance', 'FontSize', 14, 'FontWeight', 'bold');
    title('Likelihood of Passenger Acceptance vs. Reimbursement Amount', 'FontSize', 16, 'FontWeight', 'bold');
    grid on;

    % Set axis properties
    ax = gca;
    ax.XAxis.Exponent = 0;
    ax.YAxis.Exponent = 0;
    ax.XLim = [0, R_max];
    ax.YLim = [0, 1];
    ax.FontSize = 14;
    set(ax, 'Color', 'w');
    set(figHandle, 'Color', 'w');

    line([R_0 R_0], ylim, 'Color', 'red', 'LineWidth', 2); % Red line at R_0
    
    offset = (R_max - R_min) * 0.01; % Calculate a small offset based on the range
    labelPosition = R_0 - offset; % Position the label to the left of R_0
    
    text(labelPosition, 0.5, 'Base Reimbursement \newline                     \fontsize{10}{Ticket Price}', 'Color', 'black', 'FontSize', 14, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');

    legendStrings = arrayfun(@(l, s) sprintf('Lambda=%.4f, Shift=%.2f', l, s), lambda_values, shift_values, 'UniformOutput', false);
    legend(legendStrings, 'Location', 'best', 'FontSize', 10); % Position inside the plot

    hold off; 
end
