% Brute Force Simulation Task Assignment on Edge Computing, this simulation
% will serve as a baseline to compare FMS to.
%% 
for loop = 10:2:20
% We will test number of devices from 10 -> 20 in increments of 2
numberOfDevices = 20;
% Minimum work requirement defined by user
workRequired = 500;
% Variables to keep track of current and min delay calculations 
delay = 0;
minDelay = intmax;
% Position of the minimum set within our array
position = 0;
% Identifying indicies within our worklist of choosen items 
indexList = {};

% Parallel Arrays containing information about each device
% Randomly generated mean from 10 -> 100 for reach deivce(Uniform Distro)
minMean = 10; maxMean = 100;
meanList = randi([minMean, maxMean], numberOfDevices,1);

% Randomly generated std -5 -> 5 for reach deivce(Uniform Distro)
minStd = -5; maxStd = 5;
stdList = randi([minStd,maxStd], numberOfDevices,1);

% Randomly generated work 100 -> 200 for each device (Uniform Distro)
minWork = 100; maxWork = 200;
workList = randi([minWork, maxWork ],numberOfDevices,1);

% Randomly generated delay from above generated variables (Normal Distro)
delayList = randn(numberOfDevices, 1);

% Use individual Stds and Means to shift values to correct distro
for i = 1:numberOfDevices
    delayList(i) = stdList(i) * delayList(i) + meanList(i);
end
% Displaying our list of normally distrubuted values
%disp(delayList)

AllX = dec2bin(0:2^numberOfDevices-1)' - '0';

% WIP: loop to iterate through chosenList (xi) as binary array
for i = 0:(numberOfDevices^2)
    out = bitand(i, 2.^(7:-1:0)) > 0

    chosenList = 3;
end



%find all combinations that meet work requirments
%combos = FindAll(workRequired, workList);


%{
%find best delay from all combinations
for i = 1:numel(combos)
    for j = 1:numel(combos{i})
        holder = find(workList == combos{i}(j));
        delay = delay + min(delayList(holder(1:end)));
    end
    if delay(1:end) < min(minDelay)
        minDelay = delay;
        position = i;
    end
    delay = 0;
end
%}

disp("-------------" + loop + " Devices----------------------------")
%disp(combos{position})
%output = minDelay;
%disp("Min Delay: " + min(output)) % Posiblility of duplicates, take the lower value 
disp("---------------------------------------------------")
end

%{
%%
% Trying every combination that meets the 500 work requirment and adding 
% up their assocated delay in "delayList" to find the mininum delay that 
% completes the job.

% Passed variables: workRequired (minimum work to be done)
%                   workList (Work each device can complete before dead)
% Returns: Complete list of all possible combinations which meet
% workRequired

function Combinations = FindAll(workRequired, workList)
    Combinations = {};
    for i = 1:numel(workList)
        findCombo(workList(i), workList(i+1:length(workList)))
    end

    function findCombo(current, rest)
        if sum(current) < workRequired
            for j = 1:numel(rest)
                findCombo([current,rest(j)], rest(j+1:end))
            end
        else
            Combinations{end+1} = current;
        end
    end
end
%}