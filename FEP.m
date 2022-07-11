%%
% Documentation to be added
%%
function [ExtPoints] = FEP(mean, std, works, range, X, W)
rangeSet = ([])
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
    if ~isequal(X(1,:), X(2,:))
        % c = Mu(a) - Mu(b) / std^2(a) - std^2(b) 

    end

end

