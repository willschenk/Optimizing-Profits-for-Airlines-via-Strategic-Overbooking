function varargout = run_with_ConsoleLog(func, varargin)
    % Print start line 
    funcName = func2str(func);
    fprintf('** Function Run:   %s \n', funcName);

    % Start timer 
    tic;

    % Call the function and get output 
    [varargout{1:nargout}] = func(varargin{:}); 

    % Stop timer and log execution time 
    elapsedTime = toc;
    fprintf('** Execution Time: %.4f seconds \n', elapsedTime);

    % Log success and return values, if any 
    fprintf('** Success:        Function %s executed with %d inputs. \n', funcName, numel(varargin)); 
end
