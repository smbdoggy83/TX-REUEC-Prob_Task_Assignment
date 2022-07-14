clear all;
clc;
%% Import Data

dataTable = table;
% Minimum work requirement defined by user
workRequired = 500;
p = .99; % Probability constant
A = sqrt(2) * erfinv(2*p - 1); % Constant

%% Begin Algorithms
for numberOfDevices = 10:2:20 % Should be 6 times, file10 - file20
    % We will test number of devices from 10 -> 20 in increments of 2

    [meanList, stdList, workList] = DataGen(dataTable, numberOfDevices);

    
%     %% Call Brute Force Algorithm
%     tic
%     [totalMean, A, totalStd] = BFTaskAssignment(meanList, stdList, workList, p, workRequired);
%     
%     %% Alternate Brute Force using P2
%     
%     alg2MinDelay = intmax;
%     tic
%     for i = 1 : (2^numberOfDevices-1) % Amount of possibilities
%         % Create x as a string
%         xString = dec2bin(i, numberOfDevices); 
%         % Convert xString to array of ints, 1's or 0's
%         x = zeros(1, numberOfDevices);
%         for jj = 1:numberOfDevices 
%             if xString(jj) == "1" 
%                 x(jj) = 1;
%             end
%         end
%         %x = str2num(check)
% 
%         %Run Function with current chosen devices x
%         [minWorkReq, totalMean, totalStd] = P2(rot90(meanList), rot90(stdList), rot90(workList), p, workRequired, x);
%         
%         % This is where the minimization occurs
%         if (minWorkReq) % Don't even try if the minimum work requirement wasn't met
%             tempDelay = totalMean + (A*totalStd);
%             if (tempDelay < alg2MinDelay)
%                 alg2MinDelay = tempDelay;
%                 alg2BestDevices = x;
%             end
%         end
%     end 
% 
%     disp("**************************************")
%     disp("Algorithm: Brute Force using P2")
%     disp("Number of Devices: " + numberOfDevices)
%     disp("Min Delay : " + num2str(alg2MinDelay))
%     disp("Chosen Set: " + num2str(alg2BestDevices))
%     toc
%     disp("**************************************")
    
    

    %% Call FMS
    % Should these steps be done in here or another file altogether?
    % Store results in .csv 
    tic
    minSolution = FMS(rot90(meanList), rot90(stdList), rot90(workList), A, workRequired)
    toc
    %% Call any other algorithms 

end % Repeat loop again with next increment of numberOfDevices
