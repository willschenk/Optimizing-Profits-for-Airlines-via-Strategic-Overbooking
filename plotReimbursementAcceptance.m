function figHandle = plotReimbursementAcceptance(P_R, R_0, lambda, shift, T)

    % Generate a range of reimbursement amounts for plotting 
    R_min = 0; 
    R_max = R_0 * 5; % Extend upper limit to see when probability approaches 1 
    R_values = linspace(R_min, R_max, 200); % Generate 200 points between R_min and R_max 

    % Calculate the probability of acceptance for each R value
    acceptance_probs = arrayfun(@(R) P_R(R, lambda, shift, T), R_values); 

    % Create a plot of the likelihood of acceptance vs. reimbursement amount 
    figHandle = figure('Visible', 'off');
    plot(R_values, acceptance_probs, 'LineWidth', 2);
    xlabel('Reimbursement Amount ($)', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Likelihood of Acceptance', 'FontSize', 14, 'FontWeight', 'bold');
    title('Likelihood of Passenger Acceptance vs. Reimbursement Amount', 'FontSize', 16, 'FontWeight', 'bold');
    grid on; 

    ax = gca;
    ax.XAxis.Exponent = 0;
    ax.YAxis.Exponent = 0; 
    ax.XLim = [R_min, R_max]; 
    ax.YLim = [0, 1]; 

    ax.FontSize = 14;

    line([R_0 R_0], ylim, 'Color', 'red', 'LineWidth', 2); 
    
    labelPosition = R_0 + (R_max - R_min) * 0.02; 
    text(labelPosition, 0.5, 'Base Reimbursement', 'Color', 'red', 'FontSize', 14, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle'); 

    set(ax, 'Color', 'w'); 
    set(figHandle, 'Color', 'w'); 
    
end
