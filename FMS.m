function minSolution = FMS(means, stdDevs, works, A, W)
%% Our main algorithm, FMS, which calls two other algorithms, RSS and FEP, to find the minimum solution to P2
%
% Inputs: 
% ~ means (μi): The average delay per device. Ex: means[2] = average delay of device 2
% ~ stdDevs (σi): The standard deviation of delay per device. Ex: stdDevs[2] = standard deviation of delay of device 2
% ~ w (wi): Work accomplished per device. Ex: w[2] = work done by device 2
% ~ p: Confidence probability. Usually 99% or 95%, represented as 0.99 or 0.95 .
% ~ W: For condition 1, total amount of work needed to meet or exceed. Ex: 500
% ~ x (xi): Chosen factor per device (1 = chosen, 2 = unchosen).  The paper refers to this as "vector X". Ex: x[2] = 1 --> device 2 was chosen.
%
% Outputs:
% ~ minSolution: The minimum solution to P2 (May change this later to be
% multiple variables in the format of Brute Force output)
%% 

%1: Call Algorithm RSS to get the search range of [0 h] in P3
[range, X] = RSS(means, stdDevs, works, A, W);
if isempty(range) || isempty(X)
    minSolution = []
    return
end
[ExtPoints] = FEP(means, stdDevs, works, range, X, W);
if isempty(ExtPoints)
    minSolution = []
    return
end
minSolution = ExtPoints; % temp for now so main doesnt error

%2: Call Algorithm FEP to obtain all the extreme points in the search range [0 h] in P3


%3: Compare all the X values of the extreme points using the objective
% function μ + Aσ to get the minimum solution to P2

end