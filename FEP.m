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
ExtPoints(2).k = 0; ExtPoints(2).solution = X(1,:);
%add range [0 h] to the range set
rangeSet(1).lower = range(1); rangeSet(1).upper = range(2);

while ~isempty(rangeSet)
    %pop the first element [a b] from Sr
    a = rangeSet(1).lower; b = rangeSet(1).upper;
    rangeSet(1) = ([]);
    if ~(isequal(X(1,:), X(2,:)))
       % Compute STDs and Means for X(1) and X(2)
       STD1 = sqrt( sum(sigSqr .* X(1,:)));
       STD2 = sqrt( sum(sigSqr .* X(2,:)));
       mean1 = sum(mean .* X(1,:)); 
       mean2 = sum(mean .* X(2,:));
       % The cross point c
       c = mean1 - mean2 / STD1^2 - STD2^2

    end

end

