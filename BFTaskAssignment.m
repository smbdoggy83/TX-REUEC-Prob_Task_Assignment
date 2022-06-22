% Brute Force Simulation Task Assignment on Edge Computing, this simulation
% will serve as a baseline to compare FMS to.
%% 

% Parallel Arrays containing information about each device

% We will test number of devices from 10 -> 20 in increments of 2
numberOfDevices = 10;
workRequired = 500;
delay = 0;
minDelay = intmax;
position = 0;
indexList = {};

% Randomly generated mean from 10 -> 100 for reach deivce(Uniform Distro)
minMean = 10; maxMean = 100;
meanList = randi([minMean, maxMean], numberOfDevices,1)

% Randomly generated std -5 -> 5 for reach deivce(Uniform Distro)
minStd = -5; maxStd = 5;
stdList = randi([minStd,maxStd], numberOfDevices,1)

% Randomly generated work 100 -> 200 for each device (Uniform Distro)
minWork = 100; maxWork = 200;
workList = randi([minWork, maxWork ],numberOfDevices,1)

% Randomly generated delay from above generated variables (Normal Distro)
delayList = randn(numberOfDevices, 1)
for i = 1:numberOfDevices
    delayList(i) = stdList(i) * delayList(i) + meanList(i);
end
disp(delayList)

%find all combinations
combos = FindAll(workRequired, workList);

%find best delay
for i = 1:numel(combos)
    for j = 1:numel(combos{i})
        holder = find(workList == combos{i}(j));
        delay = delay + delayList(holder);
    end
    if delay<minDelay
        minDelay = delay;
        position = i
    end
    delay = 0;
end
display(combos{position})
output = [minDelay];
disp(output)

%%
% Trying every combination
% that meets the 500 work requirment, saving all of the combination's
% indexes in a list and adding up their assocated delay in "delayList" to
% find the mininum delay that completes the job.

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
