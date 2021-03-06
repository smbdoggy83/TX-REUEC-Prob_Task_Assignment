%{
%% The FEP Algorithm takes the search space given to it and finds extreme points so that only 1 or a few device combos are chosen. 

Inputs:
~ means (μi): The average delay per device. Ex: means[2] =
    average delay of device 2 
~ stdDevs (σi): The standard deviation of delay
    per device. Ex: stdDevs[2] = standard deviation of delay of device 2 
    works: Work accomplished per device. Ex: w[2] = work done by device 2 
~ range: array representing search space, should only have two indecies
~ X: A single array of devices that best matches the inputs.
~ W: For condition 1, total amount of work needed to meet or exceed. Ex: 500 
~ x (xi): Chosen factor per device (1 = chosen, 2 = unchosen).  The
    paper refers to this as "vector X". Ex: x[2] = 1 --> device 2 was chosen.

Outputs:
~ ExtPoints: The extreme points, AKA the arrays of devices that are deemed
    most optimal
%}
function [ExtPoints] = FEP(mean, std, works, range, X, W, searchArgument)
global cList;
rangeSet = ([]);
sigSqr = std.^2; % Square each element for future calculations

% Check to see if solutions are the same
if isequal(X(1,:), X(2,:)) 

    % add [0 X(0)] to the extreme point set Sp and return
    ExtPoints(1).k = 0; ExtPoints(1).solution = X(1,:);
    return
end

%add [0 X(0)] and [h X(h)] to the extreme point set Sp
ExtPoints(1).k = 0; ExtPoints(1).solution = X(1,:);
ExtPoints(2).k = range(2); ExtPoints(2).solution = X(2,:);

%add range [0 h] to the range set
rangeSet(1).lower = range(1); rangeSet(1).upper = range(2);
rangeSet(1).aSet = X(1,:); rangeSet(1).bSet = X(2,:);

while ~isempty(rangeSet)

    % pop the first element [a b] from Sr
    a = rangeSet(end).lower; b = rangeSet(end).upper;
    aSet = rangeSet(end).aSet; bSet = rangeSet(end).bSet;
    rangeSet(end) = ([]);
    if ~(isequal(aSet, bSet))

       % Compute STDs and Means for X(1) and X(2)
       STD1 = sqrt( sum(sigSqr .* aSet));
       STD2 = sqrt( sum(sigSqr .* bSet));
       mean1 = sum(mean .* aSet); 
       mean2 = sum(mean .* bSet);

       % The cross point c
       %% This is the only difference between the main search method and Binary Search
       if (searchArgument == "BS")
           c = (a + b) / 2;
       else
           c = -1*((mean1 - mean2) / (STD1^2 - STD2^2));
       end

       if isnan(c)
         ExtPoints = [] 
         return
       end
       if c ~= a && c ~= b
           cList(end+1) = c;
           [Xc, ~] = P3_2(c, W, mean, std, works);
           Xc = round(Xc');
           if isequal(Xc, aSet) && ~isequal(Xc, bSet)
               % add range (c b] to Range Set
               rangeSet(end+1).lower = c; rangeSet(end).upper = b;
               rangeSet(end).aSet = Xc; rangeSet(end).bSet = bSet;

           elseif ~isequal(Xc, aSet) && isequal(Xc, bSet)
               % add range [a c) to Sr
               rangeSet(end+1).lower = a; rangeSet(end).upper = c;
               rangeSet(end).aSet = aSet; rangeSet(end).bSet = Xc;

           elseif ~isequal(Xc, aSet) && ~isequal(Xc, bSet)
               % add [c X(c)] to Sp and add ranges [a c) and [c b] to Sr
               ExtPoints(end+1).k = c; ExtPoints(end).solution = Xc;
               rangeSet(end+1).lower = a; rangeSet(end).upper = c;
               rangeSet(end).aSet = aSet; rangeSet(end).bSet = Xc;
               rangeSet(end+1).lower = c; rangeSet(end).upper = b;
               rangeSet(end).aSet = Xc; rangeSet(end).bSet = bSet;

           end
       end

    end
end
