%%
% Documentation to be added
%%
function [ExtPoints] = FEP(mean, std, works, range, X, W)

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
    a = rangeSet(1).lower; b = rangeSet(1).upper;
    aSet = rangeSet(1).aSet; bSet = rangeSet(1).bSet;
    rangeSet(1) = ([]);
    if ~(isequal(aSet, bSet))
       % Compute STDs and Means for X(1) and X(2)
       STD1 = sqrt( sum(sigSqr .* aSet));
       STD2 = sqrt( sum(sigSqr .* bSet));
       mean1 = sum(mean .* aSet); 
       mean2 = sum(mean .* bSet);
       % The cross point c
       c = (mean1 - mean2) / (STD1^2 - STD2^2)
       if c ~= a && c ~= b
           [Xc, ~] = P3_2(c, W, mean, std, works);
           Xc = round(Xc');
           if isequal(Xc, aSet) && ~isequal(Xc, bSet)
               % add range (c b] to Range Set
               rangeSet(end+1).lower = c; rangeSet(end).upper = b;
               rangeSet(end).aSet = Xc; rangeSet(end).bSet = bSet;
               if ~isempty(rangeSet)
               rangeSet(1)
               length(rangeSet)
               end
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
       else
           if ~isempty(rangeSet)
               rangeSet(1)
               disp('Else')
           end
       end
       
    end
end
% Do not really know how to make c inclusive or exclusetive for searching
