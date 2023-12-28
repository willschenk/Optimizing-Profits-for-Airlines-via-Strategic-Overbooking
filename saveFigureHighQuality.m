function saveFigureHighQuality(figHandles)
    % Save provided figure handles in high quality 
    
    % Convert single figure handle to cell array if needed 
    if ~iscell(figHandles) && ~isnumeric(figHandles)
        figHandles = {figHandles}; 
    end

    % Create Diagrams folder if it does not exist 
    diagramsFolder = fullfile(pwd, 'Diagrams');
    if ~exist(diagramsFolder, 'dir')
        mkdir(diagramsFolder);
    end


    for i = 1:length(figHandles)
        fig = figHandles{i};


        if ~isgraphics(fig, 'figure')
            warning('Invalid figure handle provided.');
            continue;
        end

        set(fig, 'Units', 'Inches');
        pos = get(fig, 'Position');
        set(fig, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);


        figName = get(fig, 'Name');
        if isempty(figName)
            figName = ['Figure', num2str(i)];
        end

        filename = fullfile(diagramsFolder, [figName, '.png']);

        print(fig, filename, '-dpng', '-r300');
    end
end
