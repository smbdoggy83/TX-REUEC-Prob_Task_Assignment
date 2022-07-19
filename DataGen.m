%{
Function for randomly generating Mean, STD, and Work for each device
This function will write its results to an output file, which will then
be used as the input file for all of our algorithims.
The variables declared here are defined within a speicifc set of
parameters for this program.
%}
function [meanList, stdList, workList] = DataGen(dataTable, numberOfDevices)

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

dataTable.Mean = meanList;
dataTable.Std= stdList;
dataTable.Work = workList;

name = "file" + numberOfDevices;

writetable(dataTable, (name))

end

