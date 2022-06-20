% Brute Force Simulation Task Assignment on Edge Computing, this simulation
% will serve as a baseline to compare FMS to.
%% 
% Parallel Arrays containing information about each device

% We will test number of devices from 10 -> 20 in increments of 2
numberOfDevices = 10;

% Randomly generated mean from 10 -> 100 for reach deivce(Uniform Distro)
minMean = 10; maxMean = 100;
meanList = (maxMean - minMean) .* rand(numberOfDevices,1) + minMean

% Randomly generated std -5 -> 5 for reach deivce(Uniform Distro)
minStd = -5; maxStd = 5;
stdList = (maxStd - minStd) .* rand(numberOfDevices,1) + minStd

% Randomly generated work 100 -> 200 for each device (Uniform Distro)
minWork = 100; maxWork = 200;
workList = (maxWork - minWork) .* rand(numberOfDevices,1) + minWork;

% Randomly generated delay from above generated variables (Normal Distro)
delayList = randn(numberOfDevices, 1)
for i = 1:numberOfDevices
    delayList(i) = stdList(i) * delayList(i) + meanList(i);
end
disp(delayList)

%%
%find the best best combination
% Assuming we will need to make a nested for loop trying every combination
% that meets the 500 work requirment, saving all of the combination's
% indexes in a list and adding up their assocated delay in "delayList" to
% find the mininum delay that completes the job.
