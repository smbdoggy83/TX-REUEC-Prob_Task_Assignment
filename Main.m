clear all;
clc;
%% Import Data
TotalMatch = 0;
BSTotalMatch = 0;
error = ([]);
errorBS = ([]);
testloop = 1;
cListAmts = zeros(3, 6 * testloop);
iterations = 1; % Tracks amount of times loop has run (can't do that currently since numberOfDevices could be any range). Used for cListAmts

for master = 1:testloop
    dataTable = table;
    global cList;

% Minimum work requirement defined by user
workRequired = 500;
p = .99; % Probability constant
A = sqrt(2) * erfinv(2*p - 1); % Constant

%% Begin Algorithms
for numberOfDevices = 10:2:20 % Should be 6 times, file10 - file20
    % We will test number of devices from 10 -> 20 in increments of 2
    cList = [];
    [meanList, stdList, workList] = DataGen(dataTable, numberOfDevices);

    
    %% Call Brute Force Algorithm
    
    %tic
    %[totalMean, A, totalStd] = BFTaskAssignment(meanList, stdList, workList, p, workRequired);
    
    %% Alternate Brute Force using P2
    
    alg2MinDelay = intmax;
    tic
    for i = 1 : (2^numberOfDevices-1) % Amount of possibilities
        % Create x as a string
        xString = dec2bin(i, numberOfDevices); 
        % Convert xString to array of ints, 1's or 0's
        x = zeros(1, numberOfDevices);
        for jj = 1:numberOfDevices 
            if xString(jj) == "1" 
                x(jj) = 1;
            end
        end
        %x = str2num(check)

        %Run Function with current chosen devices x
        [minWorkReq, totalMean, totalStd] = P2(rot90(meanList), rot90(stdList), rot90(workList), p, workRequired, x);
        
        % This is where the minimization occurs
        if (minWorkReq) % Don't even try if the minimum work requirement wasn't met
            tempDelay = totalMean + (A*totalStd);
            if (tempDelay < alg2MinDelay)
                alg2MinDelay = tempDelay;
                alg2BestDevices = x;
            end
        end
    end 

    disp("**************************************")
    disp("Algorithm: Brute Force using P2")
    disp("Number of Devices: " + numberOfDevices)
    disp("Chosen Set: " + num2str(alg2BestDevices))
    toc
    disp("**************************************")
    
    cListAmts(1, iterations) = ((2^numberOfDevices)-1)
    
    %% Call FMS
    % Store results in .csv 
    tic
    minSolution = FMS(meanList', stdList', workList', A, workRequired, p, "");
   
    if isempty(minSolution) % If no solution found, retry with new device stats
        numberOfDevices = numberOfDevices - 2;
    else
        disp("**************************************")
        disp("Algorithm: FMS")
        disp("Number of Devices: " + numberOfDevices)
        disp("Chosen Set: " + num2str(minSolution(1).solution))
        disp("Unique c values: " + length(unique(cList)))
        toc
        disp("**************************************")
    
        cListAmts(2, iterations) = length(cList);

        %% Compare Results
        if ~isempty(minSolution)
            if isequal(minSolution(1).solution, alg2BestDevices)
                TotalMatch = TotalMatch + 1;
            else
                [minWorkReq, totalMean, totalStd] = P2(meanList', stdList', workList', p, workRequired, minSolution(1).solution);
                wrongDelay = totalMean + (A*totalStd);
                error(end+1).wrong = wrongDelay;
                error(end).right = alg2MinDelay;
                error(end).percent = (wrongDelay - alg2MinDelay)/alg2MinDelay;
                if error(end).percent == 0
                    TotalMatch = TotalMatch + 1;
                end
            end
        end
    end

    %% Call any other algorithms 
    cList = []
    tic
    minSolution_BS = FMS(meanList', stdList', workList', A, workRequired, p, "BS");

    if isempty(minSolution_BS) % If no solution found, retry with new device stats
        numberOfDevices = numberOfDevices - 2;
    else
        disp("**************************************")
        disp("Algorithm: BS")
        disp("Number of Devices: " + numberOfDevices)
        disp("Chosen Set: " + num2str(minSolution_BS(1).solution))
        disp("Unique c values: " + length(unique(cList)))
        toc
        disp("**************************************")
    
        cListAmts(3, iterations) = length(cList);

        %% Compare Results
        if ~isempty(minSolution_BS)
            if isequal(minSolution_BS(1).solution, alg2BestDevices)
                BSTotalMatch = BSTotalMatch + 1;
            else
                [minWorkReq, totalMean, totalStd] = P2(meanList', stdList', workList', p, workRequired, minSolution(1).solution);
                wrongDelay = totalMean + (A*totalStd);
                errorBS(end+1).wrong = wrongDelay;
                errorBS(end).right = alg2MinDelay;
                errorBS(end).percent = (wrongDelay - alg2MinDelay)/alg2MinDelay;
                if errorBS(end).percent == 0
                    BSTotalMatch = BSTotalMatch + 1;
                end
            end
        end
    end
 
iterations = iterations + 1;

end % Repeat loop again with next increment of numberOfDevices
FMS_matchRate = TotalMatch/(6*testloop);
BS_matchRate = BSTotalMatch/(6*testloop);
disp("The FMS match rate is: " + FMS_matchRate)
disp("The BS match rate is: " + BS_matchRate)

displayResults(FMS_matchRate, BS_matchRate, errorBS, cListAmts)

end