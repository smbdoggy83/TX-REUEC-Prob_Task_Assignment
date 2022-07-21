%{
Brute Force Simulation Task Assignment on Edge Computing, this simulation
will serve as a baseline to compare FMS to.
%}
function [totalMean, A, totalStd] = BFTaskAssignment(meanList, stdList, workList, p, workRequired)
    
    A = sqrt(2) * erfinv(2*p - 1); % Constant
    totalMean = 0; % Tracking each subset's total mean
    totalStd = 0; % Tracking each subset's total std
    work = 0; % amount of work each subset completes
    
    % Variables to keep track of current and min delay calculations 
    minDelay = intmax;

    numberOfDevices = length(meanList);

    %find all combinations that meet work requirments
    for ii = 1:(2^numberOfDevices-1)
        check = dec2bin(ii, numberOfDevices); % Check is each individual set
    
        %Check which devices are chosen. If chosen create local sum of std, mean
        % and work.
        for jj = 1:numberOfDevices 
            if check(jj) == "1" 
                totalStd = totalStd + stdList(jj)^2;
                totalMean = totalMean + meanList(jj);
                work = work + workList(jj);
             end
        end
        totalStd = sqrt(totalStd); % take sqrt of std's sum for this set
        delay = totalMean + (A*totalStd); % D >= Mu + A*std
        if (delay < minDelay) && (work >= workRequired)
            minDelay = delay;
            indexList1 = check;
        end
        totalMean = 0; totalStd = 0; work = 0;
    end
    
    disp("**************************************")
    disp("Algorithm: Brute Force")
    disp("Number of Devices: " + numberOfDevices)
    disp("Min Delay : " + minDelay)
    disp("Chosen Set: " + indexList1)
    toc
    disp("**************************************")

end